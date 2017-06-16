//
//  API.swift
//  Project5
//
//  Created by Janice Chan on 4/8/17.
//  Copyright © 2017 Janice Chan. All rights reserved.
//

import UIKit

class API {
    
    let link = "https://raw.githubusercontent.com/dennisfedorko/test-json/master/test.json"
    
    
    func fetchTinderStackData(completion: @escaping ([Person]) -> ()) {
        
        guard let url = URL(string: link) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let unwrappedData = data {
                if let dictionary = self.getDictionaryFromData(data: unwrappedData) {
                    let tinderStack = self.getTinderStackFromJSON(json: dictionary)
                    completion(tinderStack)
                }
            }
            
        }
        
        task.resume()
        
    }
    
    func getDictionaryFromData(data: Data) -> [String: Any]? {
        
        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            if let jsonDictionary = jsonObject as? [String: Any] {
                return jsonDictionary
            }
        }
        
        return nil
    }
    
    func getTinderStackFromJSON(json: [String: Any]) -> [Person] {
        
        var tinderStack = [Person]()
        
        if let tinderDataJSONArray = json["people"] as? [[String: Any]] {
            for tinderDataJSON in tinderDataJSONArray {
                
                var person: Person? = nil
                
                
                if let name = tinderDataJSON["first_name"] as? String, let imageURLString = tinderDataJSON["picture"] as? String {
                    person = Person(name: name, photo: getImageFromURLString(urlString: imageURLString))
                    
                }
                if let unwrappedPerson = person {
                    tinderStack.append(unwrappedPerson)
                }
                
            }
        }
        
        return tinderStack
    }
    
    
    func getImageFromURLString(urlString: String) -> UIImage? {
        
        let imageURL = URL(string: urlString)!
        if let imageData = try? Data(contentsOf: imageURL) {
            let image = UIImage(data: imageData)
            return image
        }
        
        return nil
    }
}
