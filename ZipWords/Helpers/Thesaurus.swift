//
//  Thesaurus.swift
//  VocabBuilder
//
//  Created by Memo on 7/19/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Thesaurus {
    
    //    static var synonyms: [Synonym] = []
    
    static func getSynonymsFor(word: String, completion: @escaping ([String]) -> Void) {
        
        let appId = "f3d865c4"
        let appKey = "3eda87c3cade9b19556d0c3eec35f77a"
        
        // words must be lowercased
        let language = "en"
        let wordID = word.lowercased()
        
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/entries/\(language)/\(wordID)/synonyms;antonyms")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data,
                
                
                // Parse jason data and create synonym array
                let jsonData = try? JSON(data: data) {
                
                var synonyms: [String] = []
                
                let synonymListJSON = jsonData["results"][0]["lexicalEntries"][0]["entries"][0]["senses"][1]["synonyms"].arrayValue
                for synonymData in synonymListJSON {
                    let synonym: Synonym  = Synonym(json: synonymData)
                    if synonym.text.contains(" ") == false {
                        let synonymText = synonym.text
                        synonyms.append(synonymText)
                    }
                }
                
                completion(synonyms)
                
            } else {
                completion([])
            }
            
        }).resume()
        
    }
    
    
}
