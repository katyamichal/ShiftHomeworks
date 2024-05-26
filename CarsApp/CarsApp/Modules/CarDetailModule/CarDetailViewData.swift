//
//  CarDetailViewData.swift
//  CarsApp
//
//  Created by Catarina Polakowsky on 26.05.2024.
//

import Foundation
struct CarDetailViewData {
    let id: Int
    let body: [Body]
    var currentBody: Body?
}
extension CarDetailViewData {
    init(with id: Int, with body: [Body]) {
        self.id = id
        self.body = body
        currentBody = body.first
    }
}
