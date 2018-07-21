//
//  ViewController.swift
//  VocabBuilder
//
//  Created by Memo on 7/16/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var startButton: UIButton!
    
    // Variables for Timer
    var startInt = 3
    @objc var startTimer = Timer()
    
    
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
        
    }
    
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
    
        
//        // Set the start time variable
//        startInt = 3
//        // Changing the title of of Button to the variable we created before
//        startButton.setTitle(String(startInt), for: .normal)
//        // Equating the startTimer variable to Create a timer and schedules it on the current run loop in the default
//        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startGameTimer), userInfo: nil, repeats: true)
//        self.
        self.performSegue(withIdentifier:"startGameSegue", sender: self)
    }
    
}

//extension ViewController{
//    // Function to start the timer for Home Screen
//    @objc func startGameTimer(){
//        // Decrementing the value of Timer by 1 everytime the function is called
//        startInt -= 1
//        // After decrementing the value of variable update the label with new value
//        startButton.setTitle(String(startInt), for: .normal)
//        // Whenever the loop ends stop the time timer and go to the next view controller segue way
//        if startInt == 0 {
//            // Stopping the timer
//            startTimer.invalidate()
//            // Performing segue for going to next view controller
//            self.performSegue(withIdentifier:"startGameSegue", sender: self)
//        }
//    }
//}

