//
//  UnsplashModelDTO.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import Foundation

struct UnsplashSearchResults: Decodable {
    let results: [UnsplashImage]
}

struct UnsplashImage: Decodable {
    let id: String
    let urls: Urls
}

struct Urls: Decodable {
    let regular: String
}
