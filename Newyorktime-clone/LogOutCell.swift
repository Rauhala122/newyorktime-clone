//
//  LogOutCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 2.6.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class LogOutCell: UICollectionViewCell {
    
    var newsController: NewsVC?
    
    lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }
    
    func setButton() {
        addSubview(logOutButton)
        logOutButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        logOutButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logOutButton.heightAnchor.constraint(equalTo: heightAnchor, constant: -10).isActive = true
        logOutButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
