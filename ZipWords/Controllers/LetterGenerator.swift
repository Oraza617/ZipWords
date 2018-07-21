//
//  ArrayGenerator.swift
//  VocabBuilder
//
//  Created by Owais Raza on 7/17/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import Foundation

struct LetterGenerator {
    
    static func generate() -> String {
        let allLetters: [String] = ["A", "B", "C", "D", "E", "F", "G",
                                    "H", "I", "J", "K", "L", "M", "N",
                                    "O", "P", "Q", "R", "S", "T", "U",
                                    "V", "W", "X", "Y", "Z", "Pre", "Anti","Extra", "Hyper", "Macro", "Micro", "Mid", "Mis", "Circum", "Dis", "De", "Homo", "Infa", "Co"]
    
        let randomNumber = Int(arc4random_uniform(25))
        return (allLetters[randomNumber])
    }
 
    
}
