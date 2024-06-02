//
//  ImageManager.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit
//enum  {
//
//    static let imageLoadingSession = "ImageDownloadingSession"
//}


protocol IImageService: AnyObject {
    func fetchImage(with url: URL, id: UUID)
    var imageBackgroundCompletion: ((UIImage?, APIError?) -> Void)? { get set }
    var progressHandler: ((UUID, Double) -> Void)? { get set}
    
}

final class ImageService: NSObject, IImageService {

    private var cache = NSCache<NSURL, UIImage>()
    
    var imageBackgroundCompletion: ((UIImage?, APIError?) -> Void)?
    var progressHandler: ((UUID, Double) -> Void)?
    
    private var tasks = [UUID: URLSessionDownloadTask]()
    
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "ImageDownloadingSession")
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()

    
    func fetchImage(with url: URL, id: UUID) {
        if let cachedImage = cache.object(forKey: url as NSURL) {}
        let task: URLSessionDownloadTask
        task = urlSession.downloadTask(with: url)
        task.resume()
        tasks.updateValue(task, forKey: id)
    }
}

extension ImageService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let imageId = tasks.first(where: { $0.value == downloadTask })?.key else { return }
        do {
            let data = try Data(contentsOf: location)
            guard let image = UIImage(data: data) else {
                imageBackgroundCompletion?(nil, .invalidResponse())
                return
            }
            //cache.setObject(image, forKey: location as NSURL)
            imageBackgroundCompletion?(image, nil)
        } catch {
            imageBackgroundCompletion?(nil, .urlSessionError("Error with request"))
        }
    }
    
    // через кложур передавать состояние загрузки
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        guard let imageId = tasks.first(where: { $0.value == downloadTask })?.key else { return }
        
        let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
        progressHandler?(imageId, progress)
        print(progress)
    }
}
