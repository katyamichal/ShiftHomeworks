//
//  ImageListPresenter.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

protocol IImageListPresenter: AnyObject {
    func viewDidLoaded(view: IImageView)
    func getRowCountInSection() -> Int
    func rowForCell(tableView: UITableView, at index: IndexPath) -> UITableViewCell
    func loadData(with keyword: String)
    func updateRow(at index: Int)
    
}

final class ImageListPresenter {
    private weak var view: IImageView?
    private var viewData: [ImageListViewData] = []
    private let service: INetworkManager
    private let imageService: IImageService
    
    private var isLoading: [UUID: Bool] = [:]
    
    init(service: INetworkManager, imageService: IImageService) {
        self.service = service
        self.imageService = imageService
        setupComplitionHandlers()
    }
    
    enum PauseLoadingImages {
        static let paused = UIImage(systemName: "pause")
        static let active = UIImage(systemName: "xmark.circle")
    }
}

extension ImageListPresenter: IImageListPresenter {
    func updateRow(at index: Int) {
        if let index = viewData.firstIndex(where: { $0.image == viewData[index].image }) {
            let id = viewData[index].image
            if  isLoading[id] == true  {
                imageService.pauseDownloading(with: id)
                viewData[index].loadingStatus = .paused(image: PauseLoadingImages.paused)
            } else {
                imageService.resumeDownloading(with: id)
            }
            isLoading[id]?.toggle()
            view?.update()
        }
    }
    
    
 
    func loadData(with keyword: String) {
        let requestId = UUID()
        viewData.append(ImageListViewData(image: requestId, loadingStatus: .loading(progress: 0.0, image: PauseLoadingImages.active)))
        service.performRequest(with: keyword, id: requestId)
        isLoading[requestId] = true
        if let index = viewData.firstIndex(where: { $0.image == requestId }) {
            viewData[index].loadingStatus = .waitToLoad(message: "Wait for loading image")
            view?.update()
        }
    }
    
    func viewDidLoaded(view: IImageView) {
        self.view = view
    }
    
    func rowForCell(tableView: UITableView, at index: IndexPath) -> UITableViewCell {
        cell(for: tableView, at: index)
    }
    
    func getRowCountInSection() -> Int {
        viewData.count
    }
}

private extension ImageListPresenter {
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableCell.reuseIdentifier, for: indexPath) as? ImageTableCell else {
            return UITableViewCell()
        }
        let data = viewData[indexPath.row]
        cell.currentState = data.loadingStatus
        return cell
    }
    
    func loadImage(with url: URL, imageId: UUID) {
        imageService.fetchImage(with: url, id: imageId)
    }
    
    func setupComplitionHandlers() {
        configureServiceCompletionHandler()
        configureImageCompletionHandler()
        configureDownloadingProssesHandler()
    }
    
    
    func configureServiceCompletionHandler() {
        service.backgroundCompletionHandler = { [weak self] (location, imageId) in
            if let location {
                self?.imageService.fetchImage(with: location, id: imageId)
            } else {
                DispatchQueue.main.async {
                    if let index = self?.viewData.firstIndex(where: { $0.image == imageId }) {
                        self?.viewData[index].loadingStatus = .failed(message: "Failed to fetch data from unsplash")
                    }
                    self?.view?.update()
                }
            }
        }
    }
        
    func configureImageCompletionHandler() {
        imageService.imageBackgroundCompletion = { [weak self] imageId, image, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let index = self.viewData.firstIndex(where: { $0.image == imageId }) else { return }
                
                if let image = image {
                    self.viewData[index].loadingStatus = .completed(image: image)
                } else {
                    self.viewData[index].loadingStatus = .failed(message: "Failed to fetch image")
                }
                self.view?.update()
            }
        }
    }

    // MARK: - Progress

    func configureDownloadingProssesHandler() {
        imageService.progressHandler = { [weak self] (imageId, progressValue) in
            DispatchQueue.main.async {
                if let index = self?.viewData.firstIndex(where: { $0.image == imageId }) {
                    self?.viewData[index].loadingStatus = .loading(progress: Float(progressValue), image: PauseLoadingImages.active)
                }
                self?.view?.update()
            }
        }
    }
}

