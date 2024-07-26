//
//  TextView+EmptyValidation.swift
//  HWS-74
//
//  Created by Mateusz Bereta on 26/07/2024.
//

import UIKit

extension UITextView {
    func setColor() {
        if self.text.isEmpty {
            self.textColor = UIColor.lightGray
        } else {
            self.textColor = UIColor.black
        }
    }
    
    func setText(){
        if self.text.isEmpty {
            self.text = "Placeholder"
        } 
    }
    
    func isEmptyWithPlaceholder() -> Bool {
        return self.text.isEmpty || self.text == "Placeholder"
    }
}
