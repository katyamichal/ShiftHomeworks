//
//  Car.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

struct Car {
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
    
    
    var description: String {
        let yearOfIssue = yearOfIssue != nil ? "\(yearOfIssue!)" : "-"
        return "manufacturer: \(manufacturer)\n model: \(model)\n body: \(body)\n yearOfIssue: \(yearOfIssue)"
    }
    
    static func createSampleData() -> [Car] {
        let car1 = Car(manufacturer: "Toyota", model: "Camry", body: .sedan, yearOfIssue: 2020, carNumber: "ABC123")
        let car2 = Car(manufacturer: "Ford", model: "F-150", body: .pickup, yearOfIssue: 2018, carNumber: "XYZ456")
        let car3 = Car(manufacturer: "Honda", model: "CR-V", body: .crossover, yearOfIssue: 2019, carNumber: "DEF789")
        let car4 = Car(manufacturer: "Chrysler", model: "Pacifica", body: .minivan, yearOfIssue: 2017, carNumber: nil)
        return [car1, car2, car3, car4]
        
    }
}


enum Body: String, CaseIterable {
    case sedan
    case pickup
    case crossover
    case minivan
}
