//
//  ImageListPresenter.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

protocol IImageListPresenter: AnyObject {
}

final class ImageListPresenter {
    private weak var view: IImageView?
}

extension ImageListPresenter: IImageListPresenter {}
