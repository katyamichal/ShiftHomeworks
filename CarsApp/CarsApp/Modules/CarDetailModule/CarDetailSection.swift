//
//  CarDetailSection.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import Foundation
enum CarDetailSection: Int, CaseIterable {
    case carImage = 0
    case price
    case bodyType
}

enum CarDetailSectionTitle: String {
    case image = "Car"
    case price = "Price"
    case bodyType = "Choose car body type"
}
