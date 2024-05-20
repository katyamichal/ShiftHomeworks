//
//  BirdDetailModel.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import Foundation

final class BirdDetailModel {
    
    let bird: Bird
    
    init(bird: Bird) {
        self.bird = bird
    }
    
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
