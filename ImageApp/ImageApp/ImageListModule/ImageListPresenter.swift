//
//  ImageListPresenter.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

final class ImageListPresenter {
    private weak var view: IImageView?
    private var viewData: [ImageListViewData] = []
    private let service: INetworkService
    private let imageService: IImageService
    private var progress: [UUID: Float] = [:]
    
    // MARK: - Init
    
    init(service: INetworkService, imageService: IImageService) {
        self.service = service
        self.imageService = imageService
        setupComplitionHandlers()
    }
}

// MARK: - IImageListPresenter protocol methods

extension ImageListPresenter: IImageListPresenter {
    func prepareForLoading(with keyword: String) {
        guard checkForEmptyTextField(with: keyword) else {
            return
        }
        let requestId = generateRequestID()
        appendNewLoadingStatus(with: requestId, and: .loading(progress: 0.0, image: PauseLoadingImages.active))
        view?.isReadyForLoading(with: keyword, and: requestId)
    }
    
    func loadData(with keyword: String, and id: UUID) {
        service.performRequest(with: keyword, id: id)
        updateLoadingStatus(with: id, .waitToLoad(message: Constants.CellLoadingMessage.waitForLoad))
    }
    
    func updateViewData(with id: UUID) {
        viewData.append(ImageListViewData(imageID: id, loadingStatus: .loading(progress: 0.0, image: PauseLoadingImages.active)))
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
    
    func updateRow(at index: Int) {
        let id = viewData[index].imageID
        let loadingStatus = viewData[index].loadingStatus
        switch loadingStatus {
        case .loading:
            viewData[index].loadingStatus = .paused(image: PauseLoadingImages.paused)
            imageService.pauseDownloading(with: id)
        case .paused:
            guard let currentProgress = progress[id] else { return }
            viewData[index].loadingStatus = .loading(progress: currentProgress, image: PauseLoadingImages.active)
            imageService.resumeDownloading(with: id)
        case .failed, .waitToLoad, .completed, .nonActive:
            break
        }
        view?.updateView()
    }
    
    func permitDeleting(at index: IndexPath) -> Bool {
        let loadingStatus = viewData[index.row].loadingStatus
        switch loadingStatus {
        case .loading, .waitToLoad, .paused, .nonActive:
            return false
        case .failed, .completed:
            return true
        }
    }
    
    func deleteRow(at index: IndexPath) {
        viewData.remove(at: index.row)
        view?.deleteRow(at: index)
    }
    
    func heightForRow(at index: Int) -> CGFloat {
        let loadingStatus = viewData[index].loadingStatus
        switch loadingStatus {
        case .loading, .waitToLoad, .paused:
            return 100
        case .failed, .completed:
            return 200
        case .nonActive:
            return 0
        }
    }
}
// MARK: - Private helper methods

private extension ImageListPresenter {
    enum PauseLoadingImages {
        static let paused = UIImage(systemName: Constants.UIElementNameStrings.pausedImage)
        static let active = UIImage(systemName: Constants.UIElementNameStrings.activeImage)
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableCell.reuseIdentifier, for: indexPath) as? ImageTableCell else {
            return UITableViewCell()
        }
        let data = viewData[indexPath.row]
        cell.currentState = data.loadingStatus
        return cell
    }
    
    func checkForEmptyTextField(with keyword: String) -> Bool {
        let searchKeyword = keyword.trimmingCharacters(in: .whitespaces)
        guard !searchKeyword.isEmpty else {
            view?.showAlert(with: .emptyTextField)
            return false
        }
        return true
    }
    
    func generateRequestID() -> UUID {
        return UUID()
    }
    
    func appendNewLoadingStatus(with id: UUID, and status: LoadingStatus) {
        viewData.append(ImageListViewData(imageID: id, loadingStatus: .loading(progress: 0.0, image: PauseLoadingImages.active)))
    }
    
    func updateLoadingStatus(with id: UUID, _ status: LoadingStatus) {
        if let index = viewData.firstIndex(where: { $0.imageID == id }) {
            viewData[index].loadingStatus = status
            view?.updateView()
        }
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
        service.backgroundCompletionHandler = { [weak self] (imageUrl, imageId, error) in
            guard let self = self else { return }
            if let imageUrl {
                self.imageService.fetchImage(with: imageUrl, id: imageId)
            } else {
                if let index = self.viewData.firstIndex(where: { $0.imageID == imageId }) {
                    let failedMessage = self.configureErrorResponse(with: error!)
                    self.viewData[index].loadingStatus = .failed(message: failedMessage)
                    DispatchQueue.main.async {
                        self.view?.updateView()
                    }
                }
            }
        }
    }
    
    func configureImageCompletionHandler() {
        imageService.imageBackgroundCompletion = { [weak self] imageId, image, error in
            guard let self = self else { return }
            guard let index = self.viewData.firstIndex(where: { $0.imageID == imageId }) else { return }
            if let image = image {
                self.viewData[index].loadingStatus = .completed(image: image)
            } else {
                let failedMessage = self.configureErrorResponse(with: error!)
                self.viewData[index].loadingStatus = .failed(message: failedMessage)
            }
            DispatchQueue.main.async {
                self.view?.updateView()
            }
        }
    }
    
    func configureDownloadingProssesHandler() {
        imageService.progressHandler = { [weak self] (imageId, progressValue) in
            guard let self = self else { return }
            if let index = self.viewData.firstIndex(where: { $0.imageID == imageId }) {
                self.viewData[index].loadingStatus = .loading(progress: Float(progressValue), image: PauseLoadingImages.active)
                self.progress[imageId] = Float(progressValue)
                DispatchQueue.main.async {
                    self.view?.updateView()
                }
            }
        }
    }
    
    func configureErrorResponse(with type: APIError) -> String {
        switch type {
        case .noInternetConnection:
            return Constants.CellLoadingMessage.noInternetConnection
        case .invalidURL, .decodingError, .invalidResponse:
            return Constants.CellLoadingMessage.failFetchData
        case .urlSessionError:
            return Constants.CellLoadingMessage.urlSessionError
        case .serverError:
            return Constants.CellLoadingMessage.serverError
        }
    }
}

