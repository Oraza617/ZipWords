//
//  WordCheckIfExists.swift
//  VocabBuilder
//
//  Created by Memo on 7/20/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WordChecker {
    
    var wordsDict: [String: Any] = {
        guard
            let jsonURL = Bundle.main.url(forResource: "dictionary", withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonURL),
            let wordsJSON = try? JSON(data: jsonData),
            let wordsDict = wordsJSON.dictionaryObject else {
                assertionFailure("failed to decode json")
                
                return [:]
        }
        
        return wordsDict
        
    }()
    
    func doesNotExist(wordGiven: String) -> Bool {
        // Check if word exists
        if wordsDict[wordGiven] != nil {
            return true
        } else {
            return false
        }
    }
    
}




