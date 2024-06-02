//
//  ImageListViewData.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit
enum LoadingStatus: Equatable, Hashable {
    case nonActive
    case loading(progress: Float)
    case completed(image: UIImage)
    case paused(progress: Float)
    case failed(message: String)
}

struct ImageListViewData {
    var image: UUID
    var loadingStatus: LoadingStatus
}
