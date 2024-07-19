//
//  Person.swift
//  Project10
//
//  Created by Mateusz Bereta on 18/07/2024.
//

import UIKit

class Person: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding = true
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
