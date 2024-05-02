//
//  Prints.swift
//  HW1
//
//  Created by Catarina Polakowsky on 14.04.2024.
//

import Foundation

enum Prints {
    
    enum ApplicationPrints {
        static let welcoming = "Hello! You are in Homework #1 app"
        static let getAction = "What would you like to do:"
        
        static let exitCommand = "q"
        static let exitDescription = "Quit the Homework #1 app"
        static let exitGreetingMessage = "You've left the main app. See you soon :)"
        
        static let carBaseCommand = "action"
        static let carBaseDescription = "Launch CarBase Application"
        static let carBaseGreetingMessage = "Welcome to CarBase Application"
        
        static let menu = "Menu:"
        static let nonExistCommand = "Oopsy, it seems this command doesn't exist. Please, choose one of the commands that is in the menu."
        
        static let addCar = "You've just added a new car:"
        static let addManufacturer = "Enter manufacturer: "
        static let addYearOfIsuue = "Enter year of issue(optional):"
        static let addModel = "Enter model: "
        static let carBodyType = "Car Body Type we've got:"
        static let addBody = "Enter car body type:"
        static let addCarNumber = "Enter car number (optional):"
        
        static let availableCarModels = "Car model(s):"
        static let availableBodyType = "Available car body type:"
    }
    
    
    enum UserCommandDescription {
        static let all = "view all available car models"
        static let add = "add a new car model"
        static let bodyType = "view a car list with a particular body type"
        static let quit = "exit CarBase Application"
    }
    
    
    enum ShiftsPrints {
        static let separation = "\n-----------------------------------------------\n"
        static let nextTabLine = "\n\t"
        static let nextLine = "\n"
    }
    
    
    enum InputWarnings {
        static let emptyField = "This field must not be empty."
        static let notValidNumber = "Enter number, if you don't know the year of issue, please, enter 0"
        static let nonValidYearOfIssue = "Please, note that the car must be manufactured between the years 1920 and 2024"
        static let  nonValidBodyType = "Please choose one of the available body types."
        static let emptyCarArray = "Ooopsy.. it turns out no cars has been added yet."
    }
}
