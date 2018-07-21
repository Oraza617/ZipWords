//
//  ResultViewController.swift
//  VocabBuilder
//
//  Created by Tushar  Verma on 7/18/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import UIKit

class ResultTableViewController: UIViewController {
    
    var score: Int = 0
    var wordsUsed: [String] = []
    var synonyms: [String: String] = [:]
    let defaults = UserDefaults.standard

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameInputTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var submitScoreButton: UIButton!
    
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
        
        tableView.reloadData()
        scoreLabel.text = String(score)
        getSynonyms()
        
        
    }
    
    
    @IBAction func submitScoreButtonTapped(_ sender: UIButton) {
        submitScoreButton.backgroundColor = UIColor.lightGray
        submitScoreButton.setTitle("Submitted!", for: .normal)
        submitToLeaderBoard()
        
        
    }
    

    // Submit to temporary local leaderboard function
    
    func submitToLeaderBoard() {
        let userName = nameInputTextField.text ?? ""
        let userScore = score
        
        LocalScores.scores[userName] = userScore
    }
    
    
//    func submitToLeaderBoard(){
//
//        let userName = nameInputTextField.text ?? ""
//        let userScore = String(score)
//
//        defaults.set([userName, userScore], forKey: "user")
//        defaults.synchronize()
//
//        if let users = defaults.string(forKey: "user") {
//            print(users)
//        }
//
//
//    }
    

    
    
    
    
    
}



extension ResultTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordsUsed.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as! ResultTableViewCell
        cell.wordTitleLabel.text = wordsUsed[indexPath.row]
        cell.descriptionTitleLabel.text = synonyms[wordsUsed[indexPath.row]]
        return cell
    }
    
    
}


// Synonym getter

extension ResultTableViewController {
    
    func getSynonyms() {
        //        print("Testing synonyms")
        
        for word in wordsUsed {
            var synonymText: String = ""
            Thesaurus.getSynonymsFor(word: word.lowercased()) { (synonymsArray) in
                DispatchQueue.main.sync {
                    for synonym in synonymsArray {
                        if synonym == synonymsArray[synonymsArray.count - 1] {
                            synonymText += synonym
                        } else {
                            synonymText += synonym +  ", "
                        }
                    }
                    if synonymText != "" {
                        self.synonyms[word] = synonymText
                    } else {
                        let wordToRemove = self.wordsUsed.index(of: word)!
                        self.wordsUsed.remove(at: wordToRemove)
                    }
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
}





