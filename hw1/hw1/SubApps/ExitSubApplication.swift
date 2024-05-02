//
//  ExitSubApplication.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

final class ExitSubApplication: SubApplication {
    
    init() {
        super.init(command: Prints.ApplicationPrints.exitCommand,
                   description: Prints.ApplicationPrints.exitDescription,
                   greetingMessage: Prints.ApplicationPrints.exitGreetingMessage
        )
    }
    
    override func runAction() -> SubApplicationResult {
        exit(0)
    }
}
