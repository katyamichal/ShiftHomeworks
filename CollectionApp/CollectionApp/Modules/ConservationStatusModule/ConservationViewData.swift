//
//  ConservationViewData.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import Foundation

struct ConservationViewData {
    
    private var birdConservation: BirdConservation
    
    func getData() -> BirdConservation {
        return birdConservation
    }
 
    mutating func setData(dueDate: Date) {
        birdConservation.dueDate = dueDate
    }
}

extension ConservationViewData {
    init(with birdConservation: BirdConservation) {
        self.birdConservation = birdConservation
    }
}
