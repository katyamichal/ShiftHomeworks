//
//  NetworkManager.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import Foundation

protocol INetworkService: AnyObject {
    var backgroundCompletionHandler: ((URL?, UUID) -> Void)? { get set }
    var progressHandler: ((UUID, Double) -> Void)? { get set }
    func performRequest(with keyword: String, id: UUID)
}

final class NetworkService: NSObject, INetworkService {
    var backgroundCompletionHandler: ((URL?, UUID) -> Void)?
    var progressHandler: ((UUID, Double) -> Void)?
    
    private var tasks = [UUID: URLSessionDownloadTask]()
    private let decoder = JSONDecoder()
    
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: Constants.URLSessionsIndentifiers.unsplashSession)
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    func performRequest(with keyword: String, id: UUID) {
        
        guard let url = createURL(with: keyword, id: id) else {
            backgroundCompletionHandler?(nil, id)
            return
        }
        let task: URLSessionDownloadTask
        task = urlSession.downloadTask(with: url)
        task.resume()
        tasks.updateValue(task, forKey: id)
    }
}

extension NetworkService: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let imageId = tasks.first(where: { $0.value == downloadTask })?.key else {return}
        
        do {
            let data = try Data(contentsOf: location)
            let searchResults = try decoder.decode(UnsplashSearchResults.self, from: data)
            if let firstImageURL = searchResults.results.first?.urls.regular, let imageURL = URL(string: firstImageURL) {
                backgroundCompletionHandler?(imageURL, imageId)
            } else {
                backgroundCompletionHandler?(nil, imageId)
            }
        } catch {
            backgroundCompletionHandler?(nil, imageId)
        }
    }
    
//    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
//        guard let response = task.response as? HTTPURLResponse else {
//            // server error
//            //  backgroundCompletionHandler?()
//            return
//        }
//        
//        switch response.statusCode {
//        case 300...399:
//                
//            //
//          //  400 -- invalidResponse
//            // 500 - server error
//        }
//        
//    }
}

private extension NetworkService {
    
    func createURL(with keyword: String, id: UUID) -> URL? {
        let token = "hpBPCZ8mTx5CmLuQ2uxkPEi5RVJkQHC1t_ke31oL_lE"
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.unsplash.com"
        urlComponents.path = "/search/photos"
        
        urlComponents.queryItems = [
            URLQueryItem(name: "query", value: keyword),
            URLQueryItem(name: "client_id", value: token)
        ]
        return urlComponents.url
    }
}
