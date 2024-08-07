//
//  ImageManager.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

protocol IImageService: AnyObject {
    var imageBackgroundCompletion: ((UUID, UIImage?, APIError?) -> Void)? { get set }
    var progressHandler: ((UUID, Double) -> Void)? { get set}
    func fetchImage(with url: URL, id: UUID)
    func pauseDownloading(with id: UUID)
    func resumeDownloading(with id: UUID)
    
}

final class ImageService: NSObject, IImageService {
    
    var imageBackgroundCompletion: ((UUID, UIImage?, APIError?) -> Void)?
    var progressHandler: ((UUID, Double) -> Void)?
    
    private var tasksLoadingStatus = [UUID: (url: URL, paused: Bool, resumeData: Data?)]()
    private var tasks = [UUID: URLSessionDownloadTask]()
    private var cache = NSCache<NSURL, NSData>()
    private let networkMonitor = NetworkMonitor.shared
    
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: Constants.URLSessionsIndentifiers.imageLoadingSession)
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func fetchImage(with url: URL, id: UUID) {
        if let data = cache.object(forKey: url as NSURL) {
            let image = UIImage(data: data as Data)
            imageBackgroundCompletion?(id, image, nil)
            return
        }
        
        if networkMonitor.isConnected == false {
            imageBackgroundCompletion?(id, nil, .noInternetConnection())
            return
        }
        
        let resumeData = tasksLoadingStatus[id]?.resumeData
        let task: URLSessionDownloadTask
        if let resumeData {
            task = urlSession.downloadTask(withResumeData: resumeData)
        } else {
            task = urlSession.downloadTask(with: url)
        }
        
        task.resume()
        tasksLoadingStatus.updateValue((url: url, paused: false, resumeData: resumeData), forKey: id)
        tasks.updateValue(task, forKey: id)
    }
    
    func pauseDownloading(with id: UUID) {
        guard let status = tasksLoadingStatus[id], let pausedTask = tasks[id] else { return }
//        guard let pausedTask = tasks[id] else { return }
        pausedTask.cancel { [weak self] resumedData in
            self?.tasksLoadingStatus.updateValue((url: status.url, paused: true, resumeData: resumedData), forKey: id)
        }
    }
    
    func resumeDownloading(with id: UUID) {
        guard let status = tasksLoadingStatus[id] else { return }
        tasksLoadingStatus.updateValue((url: status.url, paused: false, resumeData: status.resumeData), forKey: id)
        fetchImage(with: status.url, id: id)
    }
}

extension ImageService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let imageId = tasks.first(where: { $0.value == downloadTask })?.key else { return }
        do {
            let data = try Data(contentsOf: location)
            guard let image = UIImage(data: data) else {
                imageBackgroundCompletion?(imageId, nil, .invalidResponse())
                return
            }
            if let currentUrl = downloadTask.currentRequest?.url {
                cache.setObject(data as NSData, forKey: currentUrl as NSURL)
            }
            imageBackgroundCompletion?(imageId, image, nil)
        } catch {
            imageBackgroundCompletion?(imageId, nil, .invalidResponse())
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        guard let imageId = tasks.first(where: { $0.value == downloadTask })?.key else { return }
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        progressHandler?(imageId, progress)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard let imageId = tasks.first(where: { $0.value == task })?.key else { return }
        guard let response = task.response as? HTTPURLResponse else {
            return
        }
        switch response.statusCode {
        case 300...399:
            imageBackgroundCompletion?(imageId, nil,  .urlSessionError("\(response.statusCode)"))
        case 400...499:
            imageBackgroundCompletion?(imageId, nil,  .invalidResponse("\(response.statusCode)"))
        case 500...599:
            imageBackgroundCompletion?(imageId, nil, .serverError("\(response.statusCode)"))
        default:
            break
        }
    }
}
