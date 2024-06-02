//
//  ImageListPresenter.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

protocol IImageListPresenter: AnyObject {
    func viewDidLoaded(view: IImageView)
}

final class ImageListPresenter {
    private weak var view: IImageView?
    private let service: INetworkManager
    private let imageService: IImageService
    
    init(service: INetworkManager, imageService: IImageService) {
        self.service = service
        self.imageService = imageService
    }
}

extension ImageListPresenter: IImageListPresenter {
    func viewDidLoaded(view: IImageView) {
        self.view = view
    }
}
