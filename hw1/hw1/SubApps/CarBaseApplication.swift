//
//  CarBaseApplication.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

final class CarBaseApplication: SubApplication {
    
    private var cars: [Car] = Car.createSampleData()
    
    init() {
        super.init(command: Prints.ApplicationPrints.carBaseCommand, description: Prints.ApplicationPrints.carBaseDescription, greetingMessage: Prints.ApplicationPrints.carBaseGreetingMessage)
    }
    
    // MARK: - Menu
    
    override func runAction() -> SubApplicationResult {
        printOutMenu()
        let action = UserDataInput.string(Prints.ApplicationPrints.getAction)
        guard let userAction = UserCommand(rawValue: action) else {
            print(Prints.ApplicationPrints.nonExistCommand)
            print(Prints.ShiftsPrints.separation)
            return .resume
        }
        
        switch userAction {
        case .all:
            showCarModels()
        case .ad:
            addCar()
        case .type:
            filterByBodyType()
        case .q:
            return .exit
        }
        return .resume
    }
    
    private func printOutMenu() {
        print(Prints.ApplicationPrints.menu)
        for enumCommand in UserCommand.allCases {
            print("\(enumCommand) - \(enumCommand.description)")
        }
    }
    
    // MARK: - Add a new car to the array
    
    private func addCar() {
        defer {
            print(Prints.ShiftsPrints.separation)
        }
        let newCar = Car(manufacturer: carManufacturer, model: carModel, body: bodyType, yearOfIssue: yearOfIssue, carNumber: carNumber)
        cars.append(newCar)
        print(Prints.ShiftsPrints.nextLine + Prints.ApplicationPrints.addCar)
        printOut(result: [newCar])
        
    }
    
    // MARK: - Properties to create a new car model
    
    private var carManufacturer: String {
        UserDataInput.string(Prints.ApplicationPrints.addManufacturer).trimmingCharacters(in: .whitespaces)
    }
    
    private var carModel: String {
        UserDataInput.string(Prints.ApplicationPrints.addModel)
    }
    
    private var carNumber: String? {
        UserDataInput.optionalString(Prints.ApplicationPrints.addCarNumber)
    }
    
    private var yearOfIssue: Int? {
        while true {
            let yearOfIssueInput = UserDataInput.int(Prints.ApplicationPrints.addYearOfIsuue)
            let enumYear = ValidYearOfIssue(rawValue: yearOfIssueInput)
            
            switch enumYear {
            case .valid:
                return yearOfIssueInput
            case .nonValid:
                print(Prints.ShiftsPrints.nextLine + Prints.InputWarnings.nonValidYearOfIssue)
                continue
            case .unknown:
                return nil
            }
        }
    }
    
    private var bodyType: Body {
        while true {
            print(Prints.ApplicationPrints.carBodyType)
            Body.allCases.forEach{print($0.rawValue)}
            let bodyTypeInput = UserDataInput.string(Prints.ApplicationPrints.addBody)
            
            guard let bodyType = convertToBodyType(bodyType: bodyTypeInput) else {
                print(Prints.InputWarnings.nonValidBodyType)
                continue
            }
            return bodyType
        }
    }
    
    
    
    // MARK: - Printouts
    
    private func showCarModels() {
        defer {
            print(Prints.ShiftsPrints.separation)
        }
        guard !cars.isEmpty else {
            print(Prints.InputWarnings.emptyCarArray + Prints.ShiftsPrints.nextLine)
            return
        }
        print(Prints.ApplicationPrints.availableCarModels)
        printOut(result: cars)
    }
    
    private func printOut(result: [Car]) {
        for (index, car) in result.enumerated() {
            print("\(index + 1). " + car.description)
        }
        print(Prints.ShiftsPrints.nextTabLine)
    }
    
    // MARK: - filter by car body type
    
    private func filterByBodyType() {
        defer {
            print(Prints.ShiftsPrints.separation)
        }
        repeat {
            print(Prints.ApplicationPrints.availableBodyType)
            Body.allCases.forEach{print($0.rawValue)}
            let filterTypeInput = UserDataInput.string(Prints.ApplicationPrints.addBody).lowercased()
            let filteredCars = cars.filter { $0.body == convertToBodyType(bodyType: filterTypeInput) }
            
            guard !filteredCars.isEmpty else {
                print(Prints.InputWarnings.nonValidBodyType)
                continue
            }
            
            print(Prints.ApplicationPrints.availableCarModels)
            printOut(result: filteredCars)
            break
        } while true
    }
    
    
    private func convertToBodyType(bodyType: String) -> Body? {
        Body(rawValue: bodyType)
    }
}

