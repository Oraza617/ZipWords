//
//  ViewScoresTableViewController.swift
//  VocabBuilder
//
//  Created by Tushar  Verma on 7/19/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import Foundation
import UIKit

class ViewScoresTableViewController: UIViewController {
    
    var users: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
//    func getUsers() {
//        for user in LocalScores.scores {
//            users.append()
//        }
//    }
    
    
    
}

extension ViewScoresTableViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoresTableCell", for: indexPath) as! ScoresTableCell
        
        cell.standingLabel.text = String(indexPath.row)
        cell.userScoreLabel.text = ""
        cell.usernameLabel.text = ""
        
        return cell
    }


}

