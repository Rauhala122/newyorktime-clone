//
//  MenuCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 24.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

private let highlightedColor = UIColor(rgb: 0xD8D8D8) 

class MenuCell: UICollectionViewCell {
    
    let sectionTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "World Map Filled-100")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let lineSeperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.8, alpha: 1)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSectionTitle()
        setupImageView()
        setupLineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSectionTitle() {
        addSubview(sectionTitle)
        sectionTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 40).isActive = true
        sectionTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        sectionTitle.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        sectionTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func setupImageView() {
        addSubview(imageView)
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupLineView() {
        addSubview(lineSeperatorView)
        lineSeperatorView.leftAnchor.constraint(equalTo: sectionTitle.leftAnchor).isActive = true
        lineSeperatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lineSeperatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lineSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
}
extension UIColor {
    convenience init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0xFF00) >> 8) / 255.0, blue: CGFloat(rgb & 0xFF) / 255.0, alpha: alpha)
    }
}
