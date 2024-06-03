//
//  Constants.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import Foundation
enum Constants {
    enum CellLoadingMessage {
        static let waitForLoad = "Wait for loading image"
        static let failFetchData = "Failed to load data from Unsplash. Check the name you entered and try again. If you want to delete this message, swipe right then"
        static let failFetchImage = "Failed to load image. If you want to delete this message, swipe right then"
    }
    
    enum AlerMessagesType {
        case emptyTextField
        
        var title: String {
            switch self {
            case .emptyTextField:
                return "The empty field"
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
