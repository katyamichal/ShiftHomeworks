//
//  Application.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

final class Application {
    
    private let subApplications = [CarBaseApplication(), ExitSubApplication()]
    
    func run() {
        print(Prints.ApplicationPrints.welcoming)
        while true {
            let action = getAction()
            for application in subApplications {
                if application.command == action {
                    application.run()
                    break
                }
            }
            print(Prints.ShiftsPrints.separation)
        }
    }
    
    private func getAction() -> String {
        var description = Prints.ApplicationPrints.getAction
        for application in subApplications {
            description += Prints.ShiftsPrints.nextLine + "\(application.command) - \(application.description)"
        }
        return UserDataInput.string(description)
    }
}
