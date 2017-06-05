//
//  PageCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 31.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            imageView.image = UIImage(named: page!.imageName!)
            
            let titleColor = UIColor(white: 0, alpha: 1)
            
            let attributedText = NSMutableAttributedString(string: page!.title!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 24), NSForegroundColorAttributeName: titleColor])
            let messageColor = UIColor(white: 0.5, alpha: 1)
            attributedText.append(NSAttributedString(string: "\n\n\(page!.message!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSForegroundColorAttributeName: messageColor]))
            
            let paragrapStyle = NSMutableParagraphStyle()
            paragrapStyle.alignment = .center
            
            let length = attributedText.string.characters.count
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragrapStyle, range: NSRange(location: 0, length: length))
            
            textView.attributedText = attributedText
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let lineSeperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.8, alpha: 1)
        return view
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.isSelectable = false
        
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImageView()
        setTextView()
        setLineSeperatorView()
    }
    
    func setImageView() {
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -180).isActive = true
    }
    
    func setLineSeperatorView() {
        addSubview(lineSeperatorView)
        lineSeperatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        lineSeperatorView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        lineSeperatorView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        lineSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setTextView() {
        addSubview(textView)
        textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
