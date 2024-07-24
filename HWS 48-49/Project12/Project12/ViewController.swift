//
//  ViewController.swift
//  Project12
//
//  Created by Mateusz Bereta on 19/07/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")

        let dict = ["Name": "Paul", "Country": "UK"]
        defaults.set(dict, forKey: "SavedDict")
        
        let arraySaved = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
        
        let dictSaved  = defaults.object(forKey: "SavedDict") as? [String: String] ?? [String: String]()
    }


}

