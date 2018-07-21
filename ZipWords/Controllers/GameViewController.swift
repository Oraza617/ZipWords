//
//  GameViewController.swift
//  VocabBuilder
//
//  Created by Memo on 7/16/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {
    
    // Variables for timer and array of words used
    
    var randomLetter: String = LetterGenerator.generate()
    var wordsUsed: [String] = []
    var words: String = "Words Used: " // Delete this later
    var gameInt = 60
    var gameTimer = Timer()
    var totalScore: Int = 0
//    var wordChecker: WordChecker = WordChecker()
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var letterLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var wordInputTextField: UITextField!

    
    @IBOutlet weak var testLabel: UILabel! // To delete label
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationController?.isNavigationBarHidden = true
        //self.navigationController?.popViewController(animated: true)
        self.wordInputTextField.delegate = self
        errorLabel.isHidden = true
        letterLabel.text = randomLetter
        wordInputTextField.autocorrectionType = .no
        
        // Start timer for game screen
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.game), userInfo: nil, repeats: true)
        
        // Show keyboard when view loads
        wordInputTextField.becomeFirstResponder()
        
    }
    
    // Prepare what to send to the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultTableViewController {
            resultViewController.score = totalScore
            resultViewController.wordsUsed = wordsUsed
        }
    }
    
    //Disables the space bar
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        let characterSet = CharacterSet.letters
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true

    }
    
    // Function that with "Return" button when pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Get word from text field input
        let wordGiven = wordInputTextField.text!.uppercased()
        
//        print(wordsUsed)
        
        handleWordInput(wordGiven: wordGiven)
        
        return false // Prevents keyboard from hiding
    }
    

    @IBAction func resultButtonTapped(_ sender: UIButton) {
        segueToResultViewController()
    }
    
}


// Game logic
extension GameViewController {
    
    func handleWordInput(wordGiven: String) {
        
        API.checkIfWordExists(word: wordGiven) { (exit) in
            DispatchQueue.main.async {
                
                // word is one letter
                if wordGiven.count == 1 {
                    let errorText: String = "No single letters!"
                    self.show(errorText: errorText)
                } else if wordGiven == "" {
                    let errorText: String = ""
                    self.show(errorText: errorText)
                    // word already used
                } else if self.wordsUsed.contains(wordGiven)  {
                    let errorText: String = "Already used " + wordGiven
                    self.show(errorText: errorText)

                    // word does not contain the randomLetter
                } else if wordGiven.hasPrefix(self.randomLetter) == false {
                    let errorText: String = "Must begin with " + self.randomLetter
                    self.show(errorText: errorText)

                    // word exists
                } else if API.wordExists == false {
                    let wordDoesNotExist: String = "\(wordGiven) is not a word"
                    self.show(errorText: wordDoesNotExist)

                    //word sastifies the requirement
                } else {
                    self.calculateScore(wordGiven: wordGiven)
                    self.wordsUsed.append(wordGiven)
                    self.hideError()
                    self.newRandomLetter()
                }
                self.resetTextField()
            }
        }

    }
    
    
    func show(errorText: String) {
        errorLabel.text = errorText
        errorLabel.isHidden = false
    }
    
    func hideError() {
        errorLabel.isHidden = true
    }
    
    func resetTextField() {
        wordInputTextField.text = ""
    }
    
    func newRandomLetter() {
        randomLetter = LetterGenerator.generate()
        letterLabel.text = randomLetter
    }
    
    //update total score
    func calculateScore(wordGiven: String ) {
        totalScore +=  ScoreCalculator.pointCalculation(wordGiven: wordGiven)
        scoreLabel.text = String(totalScore)
    }
    
}

// Timer function and finishing functions before segue

extension GameViewController{

    @objc func game() {
        // Decrementing the game timer by 1
        gameInt -= 1
        // After decrementing the timer update label to the current value
        timeLabel.text = String(gameInt)
        // Whenever the timer is equal to 0 stop the timer and go to the result screen
        if gameInt == 0 {
            // Stop the timer
            gameTimer.invalidate()
            // Go to the result view controller
            segueToResultViewController()
        }
    }
    
    func segueToResultViewController(){
        // Perform a segue to the next view controller
        self.performSegue(withIdentifier: "resultScreenSegue", sender: self)
    }
    
}





// **** Old checker using API ***





// *** Offline checker ***

//            // word is one letter
//        if wordGiven.count == 1 {
//            let errorText: String = "No single letters!"
//            show(errorText: errorText)
//
//            // input is empty
//        } else if wordGiven == "" {
//            let errorText: String = ""
//            show(errorText: errorText)
//
//            // word already used
//        } else if self.wordsUsed.contains(wordGiven)  {
//            let errorText: String = "Already used " + wordGiven
//            show(errorText: errorText)
//
//            // word does not contain the randomLetter
//        } else if wordGiven.hasPrefix(self.randomLetter) == false {
//            let errorText: String = "Must begin with " + self.randomLetter
//            show(errorText: errorText)
//
//            // word exists
//        } else if wordChecker.doesNotExist(wordGiven: wordGiven) {
//            let wordDoesNotExist: String = "\(wordGiven) is not a word"
//            show(errorText: wordDoesNotExist)
//
//            //word sastifies the requirement
//        } else {
//            calculateScore(wordGiven: wordGiven)
//            wordsUsed.append(wordGiven)
//            hideError()
//            newRandomLetter()
//        }
//        resetTextField()













