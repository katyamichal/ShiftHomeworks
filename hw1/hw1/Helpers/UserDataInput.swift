//
//  UserDataInput.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

final class UserDataInput {
    
    static func string(_ description: String) -> String {
        while true {
            print(description)
            let str = readLine()
            guard let str, str.contains(where: { $0.isLetter }) else {
                print(Prints.InputWarnings.emptyField)
                continue
            }
            return str
        }
    }
    
    static func optionalString(_ description: String) -> String? {
        while true {
            print(description)
            let str = readLine()
            guard let str, !str.isEmpty else {
                return nil
            }
            return str
        }
    }
    
    static func int(_ input: String) -> Int {
        while true {
            print(input)
            let strInput = readLine()
            guard let strInput, let intInput = Int(strInput) else {
                print(Prints.InputWarnings.notValidNumber)
                continue
            }
            return intInput
        }
    }
}
