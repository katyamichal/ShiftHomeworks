//
//  SubApplication.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

enum SubApplicationResult {
    case resume
    case exit
}

class SubApplication {
    
    let command: String
    let description: String
    let greetingMessage: String
    
    init(command: String, description: String, greetingMessage: String) {
        self.command = command
        self.description = description
        self.greetingMessage = greetingMessage
    }
    
    func run() {
        print(greetingMessage)
        
        while true {
            let result = runAction()
            if result == .exit {
                return
            }
        }
    }
    
    func runAction() -> SubApplicationResult {
        return .resume
    }
}
