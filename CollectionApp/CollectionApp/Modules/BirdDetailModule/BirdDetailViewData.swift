//
//  BirdDetailViewData.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import Foundation


struct BirdDetailViewData {
    
    let bird: Bird
    var birdImage: String {
        bird.image
    }
    
    var birdInfo: [String] {
        [bird.description, bird.behavior, bird.physicalCharacteristics]
    }
    
    var birdConservation: BirdConservation {
        BirdConservation(conservationStatusDescription: bird.birdConservation.conservationStatusDescription, conservationStatus: bird.birdConservation.conservationStatus)
    }
    
    var birdName: String {
        bird.name
    }
}

extension BirdDetailViewData {
    init(with bird: Bird) {
        self.bird = bird
    }
}
