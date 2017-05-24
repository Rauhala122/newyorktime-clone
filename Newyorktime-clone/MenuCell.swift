//
//  MenuCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 24.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSectionTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSectionTitle() {
        addSubview(sectionTitle)
        sectionTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        sectionTitle.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        sectionTitle.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        sectionTitle.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
}
