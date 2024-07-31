//
//  Script.swift
//  Extension
//
//  Created by Mateusz Bereta on 24/07/2024.
//

import UIKit

class Script: NSObject, Codable {
    var js: String
    var title: String
    
    init(js: String, title: String) {
        self.js = js
        self.title = title
    }
    
    public override var description: String { return "Title: '\(title)' Script: '\(js)'" }
    
    static func loadScript(data: Data?) -> [Script] {
        if data == nil {
            return []
        }
        if let savedScript:[Script] = try? JSONDecoder().decode([Script].self, from: data!){
            print(savedScript)
            return savedScript
        } else {
            return []
        }
    }
    
    static func save(allScripts: [Script], url: String) {
         if let encoded = try? JSONEncoder().encode(allScripts){
            UserDefaults.standard.set(encoded, forKey: url)
         }
    }
}
