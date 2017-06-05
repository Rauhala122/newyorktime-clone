//
//  NewsCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 21.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import SwipeCellKit

class NewsCell: UICollectionViewCell {
    
    var isCellSelected = false
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
        }
    }
    
    var popularNew: PopularNews? {
        didSet {
            if let news = popularNew {
                
                let sectionColor = UIColor(white: 0.3, alpha: 1)
                let titleColor = UIColor.black
                
                let attributedText = NSMutableAttributedString(string: news.section, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: sectionColor])
                
                attributedText.append(NSAttributedString(string: "\n\(news.title)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold),NSForegroundColorAttributeName: titleColor, ]))
                
                let captionColor = UIColor(white: 0.6, alpha: 1)
                attributedText.append(NSAttributedString(string: "\n\(news.caption)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: captionColor]))
                
                let paragrapStyle = NSMutableParagraphStyle()
                paragrapStyle.alignment = .left
                
                let length = attributedText.string.characters.count
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragrapStyle, range: NSRange(location: 0, length: length))
                
                textView.attributedText = attributedText
                
                popularLabel.text = "\(news.views)."
                
                image.sd_setImage(with: URL(string: news.imageURL))
            }
        
        }
    }
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "2."
        label.textColor = UIColor(white: 0, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isSelectable = false
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(white: 0.5, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "19.5"
        return label
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cia")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Upload-50"), for: .normal)
        return button
    }()
    
    let boobmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Bookmark Ribbon-50"), for: .normal)
        return button
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var textViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
        if isCellSelected {
            backgroundView?.backgroundColor = .lightGray
        } else {
            backgroundView?.backgroundColor = .white
        }
        
    }
    
    func setupViews() {
        setupPopularLabel()
        setupImage()
        setupTextView()
        setupDateLabel()
        setupSeperatorView()
        setupShare()
        setupBookmark()
        bottomAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: 5).isActive = true
    }
    
    func setupPopularLabel() {
        addSubview(popularLabel)
        popularLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        popularLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        popularLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
        popularLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
  
    func setupTextView() {
        addSubview(textView)
        textView.leftAnchor.constraint(equalTo: popularLabel.rightAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -10).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        
        textViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 300)
        textViewHeightConstraint.isActive = true
    }

    func setupImage() {
        addSubview(image)
        image.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        image.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.leftAnchor.constraint(equalTo: textView.leftAnchor, constant: 4
            ).isActive = true
        dateLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 0).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupShare() {
        addSubview(shareButton)
        shareButton.rightAnchor.constraint(equalTo: image.rightAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    func setupSeperatorView() {
        addSubview(seperatorView)
        seperatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupBookmark() {
        addSubview(boobmarkButton)
        boobmarkButton.rightAnchor.constraint(equalTo: shareButton.leftAnchor, constant: -10).isActive = true
        boobmarkButton.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor).isActive = true
        boobmarkButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        boobmarkButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
