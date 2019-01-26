//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by Hameed Abdullah on 1/21/19.
//  Copyright © 2019 Hameed Abdullah. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    //2***
    // Display Questions and Answers
    
    //an array of Question objects
    var questions: [Question] = [
        Question(text: "Which food do you like the most?",
                 type:.single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrots", type: .rabbit),
                    Answer(text: "Corn", type: .turtle)
            ]),
        Question(text: "Which activities do you enjoy?",
                 type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .turtle),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .rabbit),
                    Answer(text: "Eating", type: .dog)
            ]),
        
        Question(text: "How much do you enjoy car rides?",
                 type: .ranged,
                 answers: [
                    Answer(text: "I dislike them", type: .cat),
                    Answer(text: "I get a little nervous",
                           type: .rabbit),
                    Answer(text: "I barely notice them",
                           type: .turtle),
                    Answer(text: "I love them", type: .dog)
            ])
    ]
    
    
    //3***
    // “Display Questions with the Right Controls Now that you have a list of questions to draw from, you'll need to keep track of which ones your app has already displayed and to calculate when you've displayed them all. One technique is to use an integer as an index into the questions collection. This integer will start at 0 (the index of the first element in a collection), and you'll increment the value by 1 after the player answers each question
    var questionIndex = 0
    
    
    //4.a***
    //“As the player moves from question to question, you'll need to show the correct stack view and to hide the other two.
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
 
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    
    @IBOutlet weak var rangedStackView: UIStackView!
    
    @IBOutlet weak var rangedSlider: UISlider!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    //6***
    // Retrieve Answers with Actions
    var answersChosen: [Answer] = [Answer]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    
    //4.b
    // The updateUI() method is responsible for updating a few key pieces of the interface, including the title in the navigation bar and the visibility of the stack views. You can use the questionIndex property to create a unique title—for example, "Question #4"—in the navigation item for each question. With the stack views, it's easiest if you hide all three stack views, then inspect the type property of the Question to determine which stack should be visible.
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        let currentQuestion = questions[questionIndex]
        
        let currentAnswers = currentQuestion.answers
        
        //for the progress view, calculate the percentage progress by dividing the questionIndex by the total number of questions.
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        navigationItem.title = "Question #\(questionIndex+1)"
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        
        //.type is ResponseType which enum single, multiple, ranged
        switch currentQuestion.type {
        case .single:
            //singleStackView.isHidden = false
            updateSingleStack(using: currentAnswers)
        case .multiple:
            //multipleStackView.isHidden = false
            updateMultipleStack(using: currentAnswers)
        case .ranged:
            //rangedStackView.isHidden = false
            updateRangedStack(using: currentAnswers)
        }
    }


    //5***
    //In the single-answer stack view, each button title corresponds to an answer. Use the setTitle(_:for:) method to update the title. The first button will use the first answer string, the second button will use the second answer string, and so on.
    func updateSingleStack(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultipleStack(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    //7***
    //“Why do you need to update the type? (UIButton) You're tying the tap from multiple buttons to this one action, so you'll need to specify which button triggered the method. You can use == to compare two UIButton objects. If the method was triggered using singleButton1, the app will know that the player selected the first answer
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        
        switch sender {
        case singleButton1:
            answersChosen.append(currentAnswers[0])
        case singleButton2:
             answersChosen.append(currentAnswers[1])
        case singleButton3:
            answersChosen.append(currentAnswers[2])
        case singleButton4:
            answersChosen.append(currentAnswers[3])
        default:
            break
        }
        
        nextQuestion()
    }
    
    
    //8**
    // For the multiple-answer user interface, you'll determine which answers to add to the collection based on the switches the player has enabled.
    //If the first switch is enabled, you want to add the first answer. Unlike the method with single-answer questions, this method allows you to append as many as four answers per question
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        
        if multiSwitch1.isOn {
            answersChosen.append(currentAnswers[0])
        }
        
        if multiSwitch2.isOn {
             answersChosen.append(currentAnswers[1])
        }
        
        if multiSwitch3.isOn {
            answersChosen.append(currentAnswers[2])
        }
        
        if multiSwitch4.isOn {
             answersChosen.append(currentAnswers[3])
        }
        
        nextQuestion()
    }
    
    //9**
    //“For a ranged response question, you'll read the current position of the UISlider and use that value to determine which answer to add to the collection.
    //“A slider's value ranges from 0 to 1, so a value between 0 and 0.25 could correspond to the first answer, and an answer between .75 and 1 could correspond to the final answer. To convert a slider value to an array's index, use the equation index = slider value * (number of answers - 1) rounded to the nearest integer”
    
  
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
    //10***
    //“Respond to Answered Questions
    //you'll increment the value of questionIndex by 1, then determine if there are any remaining questions. If there are, you'll call updateUI() to update the title and display the proper stack view. The method will use the new value of questionIndex to display the next question. If there are no questions remaining, it's time to present the results—using the ResultsSegue that you created earlier.
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    
    //12***
    //“Pass Data to the Results View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            
            //you'll have to downcast the destination property from a UIViewController to a ResultsViewController so that you can access the responses property you just added in ResultsViewController
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.responses = answersChosen
        }
    }
    
    
 
}






























