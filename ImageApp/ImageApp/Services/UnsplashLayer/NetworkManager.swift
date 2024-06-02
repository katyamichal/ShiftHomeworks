//
//  NetworkManager.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import Foundation
enum URLSessionsIndentifiers {
    static let unsplashSession = "UnsplashSearchSession"
    
}


protocol INetworkManager: AnyObject {
    var backgroundCompletionHandler: ((URL?, UUID) -> Void)? { get set }
    var progressHandler: ((UUID, Double) -> Void)? { get set }
    func performRequest(with keyword: String, id: UUID)
}

final class NetworkManager: NSObject, INetworkManager {
    var backgroundCompletionHandler: ((URL?, UUID) -> Void)?
    var progressHandler: ((UUID, Double) -> Void)?
        
    private var tasks = [UUID: URLSessionDownloadTask]()
    private let decoder = JSONDecoder()
    
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: URLSessionsIndentifiers.unsplashSession)
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    

    override init() {
        super.init()
    }
    
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

extension NetworkManager: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let imageId = tasks.first(where: { $0.value == downloadTask })?.key else {return}
        
        do {
            let data = try Data(contentsOf: location)
            let searchResults = try decoder.decode(UnsplashSearchResults.self, from: data)
            if let firstImageURL = searchResults.results.first?.urls.regular, let imageURL = URL(string: firstImageURL) {
                print(imageURL)
                backgroundCompletionHandler?(imageURL, imageId)
            } else {
                backgroundCompletionHandler?(nil, imageId)
            }
        } catch {
            print("Error reading downloaded data: \(error)")
            backgroundCompletionHandler?(nil, imageId)
        }
    }
}

private extension NetworkManager {
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