//
//  Bio.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import Foundation

struct Bio {
    let name: String
    let surname: String
    let education: String
    let hometown: String
    let image: String
    let birthDate: Date
    
    
   static func createSampleData() -> Bio {
       let myBirthday = Calendar.current.date(from: DateComponents(year: SelfPresentationStrings.BirthDate.year, month: SelfPresentationStrings.BirthDate.month, day: SelfPresentationStrings.BirthDate.day))!
       return Bio(name: SelfPresentationStrings.Bio.name, surname: SelfPresentationStrings.Bio.surname, education: SelfPresentationStrings.Bio.education, hometown: SelfPresentationStrings.Bio.hometown, image: SelfPresentationStrings.Bio.image, birthDate: myBirthday)
    }
}
