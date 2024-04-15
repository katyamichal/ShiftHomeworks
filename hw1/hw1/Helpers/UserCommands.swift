//
//  UserCommands.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation
enum UserCommand: String, CaseIterable {
    case all
    case ad
    case type
    case q
    
    var description: String {
        switch self {
        case .all:
            return Prints.UserCommandDescription.all
        case .ad:
            return Prints.UserCommandDescription.add
        case .type:
            return Prints.UserCommandDescription.bodyType
        case .q:
            return Prints.UserCommandDescription.quit
        }
    }
}
