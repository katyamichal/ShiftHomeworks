//
//  CarDTO.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import Foundation

struct Cars: Decodable {
    let cars: [Car]
}

struct Car: Hashable, Decodable {
    let id: Int
    let manufacturer: String
    let body: [Body]
}

struct Body: Hashable, Decodable {
    let type: BodyType
    let price: Int
    let image: String
}

enum BodyType: String, Decodable {
    case sedan
    case hatchback
    case SUV
    case coupe
    
    var description: String {
        switch self {
        case .sedan:
            return "Sedan"
        case .hatchback:
            return "Hatchback"
        case .SUV:
            return "Sport Utility Vehicle"
        case .coupe:
            return "Coupe"
        }
    }
}
