//
//  ValidYear.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

enum ValidYearOfIssue {
    case valid
    case nonValid
    case unknown
    
    init(rawValue: Int) {
        switch rawValue {
        case 0:
            self = .unknown
        case let x where x > 1895 && x <= Calendar.current.component(.year, from: Date()):
            self = .valid
        default:
            self = .nonValid
        }
    }
}
