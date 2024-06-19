//
//  Constants.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import UIKit

enum Constants {
    
    enum URLSessionsIndentifiers {
        static let unsplashSession = "UnsplashSearchSession"
        static let imageLoadingSession = "ImageDownloadingSession"
    }
    
    enum PlaceholderStrings {
        static let searchBarPlaceholder = "Search height-resolution images"
    }
    
    enum UIElementNameStrings {
        static let deleteActionImage = "trash"
        static let pausedImage = "pause.circle"
        static let activeImage = "xmark.circle"
    }
    
    enum CellLoadingMessage {
        static let noInternetConnection = "Poor Internet Connection. Please check your network settings and try again. Swipe right to delete this message."
        static let waitForLoad = "Please wait, loading image..."
        static let failFetchData = "Could not load image. Please check the name and try again. Swipe right to delete this message."
        static let urlSessionError = "Oops! Something went wrong while loading the image. Please try again. Swipe right to delete this message."
        static let serverError = "Our server is currently unavailable. Please try again later. Swipe right to delete this message."
    }
    
    enum AlerMessagesType {
        case emptyTextField
        
        var title: String {
            switch self {
            case .emptyTextField:
                return "The text field is empty"
            }
        }
        
        var message: String {
            switch self {
            case .emptyTextField:
                return "Please, enter an image name"
            }
        }
        var buttonTitle: String {
            "Ok"
        }
    }
}

