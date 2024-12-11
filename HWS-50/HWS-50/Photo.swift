//
//  Photo.swift
//  HWS-50
//
//  Created by Mateusz Bereta on 22/07/2024.
//

import UIKit

class Photo: NSObject, Codable {
    var image: String
    var title: String
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
}
