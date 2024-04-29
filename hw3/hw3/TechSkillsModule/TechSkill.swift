//
//  TechSkill.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import Foundation

struct TechSkill {
    let question: String
    let answer: String
    
    static func createSampleData() -> [TechSkill] {
        return [
            TechSkill(question: SelfPresentationStrings.TechSckills.question1, answer: SelfPresentationStrings.TechSckills.answer1),
            
            TechSkill(question: SelfPresentationStrings.TechSckills.question2, answer: SelfPresentationStrings.TechSckills.answer2),
        ]
    }
}
