//
//  LeftPaddedTextField.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 31.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class LeftPaddedTextField: UITextField {
    
    override func awakeFromNib() {
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 3
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
}
