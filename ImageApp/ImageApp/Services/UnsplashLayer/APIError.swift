//
//  APIError.swift
//  ImageApp
//
//  Created by Catarina Polakowsky on 02.06.2024.
//

import Foundation
enum APIError: Error {
    case urlSessionError(String)
    case noInternetConnection(String = "No Internet Connection")
    case serverError(String = "Invalid API Key")
    case invalidResponse(String = "Invalid response from server")
    case decodingError(String = "Error parsing server response")
    case invalidURL(String = "INvalid URL")
}
