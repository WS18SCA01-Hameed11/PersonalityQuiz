//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Hameed Abdullah on 1/21/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import Foundation

//1***
//create structures that hold the question data and to update the user interface based on the values of each question and its answers


struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer] //an array of Answer objects
    
}

enum ResponseType {
    case single
    case multiple
    case ranged
}


struct Answer {
    var text: String
    var type: AnimalType
}


//enum to represent each personality type—or in this case, animal type—you could include a definition property that will be presented as a label on the results screen.
enum AnimalType: Character {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .rabbit:
            return "You love everything that's soft. You are healthy and full of energy."
        case .turtle:
            return "You are wise beyond your years, and you focus on the details. Slow and steady wins the race."
        }
    }
}

























