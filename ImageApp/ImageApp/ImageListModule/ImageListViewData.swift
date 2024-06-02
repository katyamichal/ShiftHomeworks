//
//  ImageListViewData.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit
enum LoadingStatus: Equatable, Hashable {
    case nonActive
    case waitToLoad(message: String)
    case loading(progress: Float, image: UIImage?)
    case completed(image: UIImage)
    case paused(image: UIImage?)
    case failed(message: String)
}

struct ImageListViewData {
    var image: UUID
    var loadingStatus: LoadingStatus
}
