//
//  Page.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 31.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class Page {
    var imageName: String?
    var title: String?
    var message: String?
    
    init(imageName: String, title: String, message: String) {
        self.imageName = imageName
        self.title = title
        self.message = message
    }
}
