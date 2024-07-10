//
//  UIColor+Ext.swift
//  RandomColors
//
//  Created by Mateusz Bereta on 05/07/2024.
//

import UIKit

extension UIColor{
    static func random() -> UIColor {
        let randomColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        return randomColor
    }
    
    func getRGB() -> String {
        let components = self.getComponents()
        
        return("RGB(\(components[0]),\(components[1]),\(components[2]))")
    }
    
    func getComponents() -> [Int]{
        let components = self.cgColor.components ?? [0,0,0]
        var componentsInt:[Int] = []
        componentsInt.append(Int(components[0] * 255))
        componentsInt.append(Int(components[1] * 255))
        componentsInt.append(Int(components[2] * 255))
        return componentsInt
    }
    
    func getHEX() -> String {
        let components = self.getComponents()
        let red = String(components[0],radix: 16)
        let green = String(components[1],radix: 16)
        let blue = String(components[2],radix: 16)
        let colorHex = "#\(red)\(green)\(blue)"
        return(colorHex.uppercased())
    }
}

