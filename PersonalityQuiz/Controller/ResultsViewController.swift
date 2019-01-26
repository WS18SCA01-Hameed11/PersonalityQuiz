//
//  ResultsViewController.swift
//  PersonalityQuiz
//
//  Created by Hameed Abdullah on 1/21/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinitionLabel: UILabel!
    
    
    //11***
    //This property will need to be an implicitly unwrapped optional so that the view controller can be loaded from the storyboard even if the property doesn't have a value.
    var responses: [Answer]!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //14
        //After the results have been displayed, there shouldn't be a way to go back and change previously answered questions
        navigationItem.hidesBackButton = true
        
        print("responses.count \(responses.count)")
        
        calculatePesonalityResult()
    }
    
    //13***
    //Calculate Answer Frequency
    //loop through each of the Answer structs in the responses property and calculate which type was most common in the collection- use dictionary where the key is the response type and the value is the number of times it's been selected as an answer.
    func calculatePesonalityResult() {
        
        var frequencyOfAnswers: [AnimalType: Int] = [:]
        
        
        //When calculating the result, you don't need the entire Answer struct; you only care about the type property of each Answer. So you can create a new, simplified collection by mapping each Answer to its corresponding type.
        let responseTypes = responses.map { $0.type }
        
        //iterate through the collection, and add or update the key/value pair in the dictionary.
        for response in responseTypes {
            frequencyOfAnswers[response] = (frequencyOfAnswers[response] ?? 0) + 1
        }
        
        //“Determine the Most Frequent Answers
        //Now that we have a dictionary that knows the frequency of each response, it's possible to determine which value is the largest. You can use the Swift sorted(by:) method on a dictionary to place each key/value pair into an array, sorting the value properties in descending order
        
        //sorted(by:) is a closure that takes any two key/value pairs. In the animal quiz, pair1 might correspond to cat : 1 and pair2 might be dog : 2 Within the body of the closure, you'll need to return a Boolean value to help the method determine which of the pairs is larger. In the case of return 1 > 2 the Boolean value is false—so the method knows that pair2 is larger than pair1.
    
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {(pair1, pair2) -> Bool in
            return pair1.value > pair2.value
        })
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        //“update your labels with the data held in mostCommonAnswer:
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)!"
        resultDefinitionLabel.text = mostCommonAnswer.definition
    
    }
    

    // dismiss and go to IntroViewController
    @IBAction func dismissTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let introViewController = storyboard.instantiateViewController(withIdentifier: "IntroViewController")
        self.present(introViewController, animated: true, completion: nil)
    }
    
}
