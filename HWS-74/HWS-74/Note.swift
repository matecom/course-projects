//
//  Note.swift
//  HWS-74
//
//  Created by Mateusz Bereta on 25/07/2024.
//

import UIKit

let notesKey = "NOTES_KEY"

class Note: NSObject, Codable {
    var title: String
    var content: String
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
    }
    
    public override var description: String { return "Title: '\(title)', Content: '\(content)'" }

    static func load(data: Data?) -> [Note] {
        if data == nil {
            return []
        }
        if let savedNote:[Note] = try? JSONDecoder().decode([Note].self, from: data!){
            print(savedNote)
            return savedNote
        } else {
            return []
        }
    }

    static func save(allNotes: [Note]) {
         if let encoded = try? JSONEncoder().encode(allNotes){
            UserDefaults.standard.set(encoded, forKey: notesKey)
         }
    }
}
