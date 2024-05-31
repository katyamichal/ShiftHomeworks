//
//  BirdListViewData.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import Foundation

struct BirdListViewData {
    let birds: [Bird]
}

extension BirdListViewData {
    init(with birds: [Bird]) {
        self.birds = birds
    }
}
