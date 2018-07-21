//
//  Synonyms.swift
//  VocabBuilder
//
//  Created by Memo on 7/19/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Synonym {
    
    let text: String
    
    init(json: JSON) {
        self.text = json["text"].stringValue
    }
}

