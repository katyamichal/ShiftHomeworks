//
//  Hobby.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import Foundation

struct Hobby {
    let name: String
    let description: String
    let image: String
    
    static func createSampleData() -> [Hobby] {
        return [
            Hobby(name: SelfPresentationStrings.Hobbies.hobbyName1, description: SelfPresentationStrings.Hobbies.hobbyDescription1, image: SelfPresentationStrings.Hobbies.hobbyImage1),
            
            Hobby(name: SelfPresentationStrings.Hobbies.hobbyName2, description: SelfPresentationStrings.Hobbies.hobbyDescription2, image: SelfPresentationStrings.Hobbies.hobbyImage2),
            
            Hobby(name: SelfPresentationStrings.Hobbies.hobbyName3, description: SelfPresentationStrings.Hobbies.hobbyDescription3, image: SelfPresentationStrings.Hobbies.hobbyImage3),
        ]
    }
}
