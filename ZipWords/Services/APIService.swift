//
//  APIService.swift
//  VocabBuilder
//
//  Created by Memo on 7/17/18.
//  Copyright © 2018 Memo. All rights reserved.
//

import Foundation

struct API {
    
    static var wordExists: Bool = false
    
    static func checkIfWordExists(word: String, completion: @escaping(Bool) -> Void) {
        
        let appId = "f3d865c4"
        let appKey = "3eda87c3cade9b19556d0c3eec35f77a"
        
        let language = "en"
        // Fix this issue
        let url = URL(string: "https://od-api.oxforddictionaries.com:443/api/v1/inflections/\(language)/\(word)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(appId, forHTTPHeaderField: "app_id")
        request.addValue(appKey, forHTTPHeaderField: "app_key")
        
        let session = URLSession.shared
        _ = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {return}
//            print(response.statusCode)
            switch response.statusCode {
            case 200 ... 299:
                wordExists = true
            default:
                wordExists = false
            }
            
            completion(wordExists)
            
            if  let data = data,
                let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) {
//                print(jsonData)
                // Do something with the data
            } else {

                guard let data = data else{return}
//                print(NSString.init(data: data, encoding: String.Encoding.utf8.rawValue)!)
            }
            
        }).resume()
    }
    
}
