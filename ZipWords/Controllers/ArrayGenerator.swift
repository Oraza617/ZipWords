//
//  ArrayGenerator.swift
//  VocabBuilder
//
//  Created by Owais Raza on 7/17/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import Foundation

struct arrayGenerator {
    
    var alphabetArray: [String] = ["A", "B", "C", "D", "E", "F", "G",
                                   "H", "I", "J", "K", "L", "M", "N",
                                   "O", "P", "Q", "R", "S", "T", "U",
                                   "V", "W", "X", "Y", "Z"]
    
    func generateRandomArray(alphabetArray: [String]) -> [String] {
        var randomArray = [String]()
        for _ in 1...26 {
            let randomNumber = Int(arc4random_uniform(25))
            randomArray.append(alphabetArray[randomNumber])
        }
        
        return randomArray
    }
    
}
