//
//  BirdDataSource.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 07.05.2024.
//

import Foundation

protocol DataSourceProtocol: AnyObject {
    func createSampleData() -> [Bird]
}

final class BirdDataSourceImp: DataSourceProtocol {
    
    func createSampleData() -> [Bird] {
        [
            Bird(
                name: BirdSampleStrings.Kakapo.name,
                image: BirdSampleStrings.Kakapo.image,
                description: BirdSampleStrings.Kakapo.description,
                physicalCharacteristics: BirdSampleStrings.Kakapo.physicalCharacteristics,
                behavior: BirdSampleStrings.Kakapo.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription: BirdSampleStrings.Kakapo.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.Kakapo.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.FruitDove.name,
                image: BirdSampleStrings.FruitDove.image,
                description: BirdSampleStrings.FruitDove.description,
                physicalCharacteristics: BirdSampleStrings.FruitDove.physicalCharacteristics,
                behavior: BirdSampleStrings.FruitDove.behavior,
                birdConservation: BirdConservation(
                    conservationStatusDescription: BirdSampleStrings.FruitDove.conservationStatusDescription,
                    conservationStatus:  BirdSampleStrings.FruitDove.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.SnowOwl.name,
                image: BirdSampleStrings.SnowOwl.image,
                description: BirdSampleStrings.SnowOwl.description,
                physicalCharacteristics: BirdSampleStrings.SnowOwl.physicalCharacteristics,
                behavior: BirdSampleStrings.SnowOwl.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription:BirdSampleStrings.SnowOwl.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.SnowOwl.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.Ultramarine.name,
                image: BirdSampleStrings.Ultramarine.image,
                description: BirdSampleStrings.Ultramarine.description,
                physicalCharacteristics: BirdSampleStrings.Ultramarine.physicalCharacteristics,
                behavior: BirdSampleStrings.Ultramarine.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription:  BirdSampleStrings.Ultramarine.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.Ultramarine.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.AmericanGoldfinch.name,
                image: BirdSampleStrings.AmericanGoldfinch.image,
                description: BirdSampleStrings.AmericanGoldfinch.description,
                physicalCharacteristics: BirdSampleStrings.AmericanGoldfinch.physicalCharacteristics,
                behavior: BirdSampleStrings.AmericanGoldfinch.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription: BirdSampleStrings.AmericanGoldfinch.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.AmericanGoldfinch.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.EasternBluebird.name,
                image: BirdSampleStrings.EasternBluebird.image,
                description: BirdSampleStrings.EasternBluebird.description,
                physicalCharacteristics: BirdSampleStrings.EasternBluebird.physicalCharacteristics,
                behavior: BirdSampleStrings.EasternBluebird.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription:BirdSampleStrings.EasternBluebird.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.EasternBluebird.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.BlueFootedBooby.name,
                image: BirdSampleStrings.BlueFootedBooby.image,
                description: BirdSampleStrings.BlueFootedBooby.description,
                physicalCharacteristics: BirdSampleStrings.BlueFootedBooby.physicalCharacteristics,
                behavior: BirdSampleStrings.BlueFootedBooby.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription:BirdSampleStrings.BlueFootedBooby.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.BlueFootedBooby.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.EmperorPenguin.name,
                image: BirdSampleStrings.EmperorPenguin.image,
                description: BirdSampleStrings.EmperorPenguin.description,
                physicalCharacteristics: BirdSampleStrings.EmperorPenguin.physicalCharacteristics,
                behavior: BirdSampleStrings.EmperorPenguin.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription:BirdSampleStrings.EmperorPenguin.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.EmperorPenguin.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.BaldEagle.name,
                image: BirdSampleStrings.BaldEagle.image,
                description: BirdSampleStrings.BaldEagle.description,
                physicalCharacteristics: BirdSampleStrings.BaldEagle.physicalCharacteristics,
                behavior: BirdSampleStrings.BaldEagle.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription:BirdSampleStrings.BaldEagle.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.BaldEagle.conservationStatus.colour)
            ),
            
            Bird(
                name: BirdSampleStrings.ScarletMacaw.name,
                image: BirdSampleStrings.ScarletMacaw.image,
                description: BirdSampleStrings.ScarletMacaw.description,
                physicalCharacteristics: BirdSampleStrings.ScarletMacaw.physicalCharacteristics,
                behavior: BirdSampleStrings.ScarletMacaw.behavior,
                
                birdConservation: BirdConservation(
                    conservationStatusDescription:BirdSampleStrings.ScarletMacaw.conservationStatusDescription,
                    conservationStatus: BirdSampleStrings.ScarletMacaw.conservationStatus.colour)
            )
        ]
    }
    
}
