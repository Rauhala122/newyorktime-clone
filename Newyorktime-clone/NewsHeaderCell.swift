//
//  NewsHeaderCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 21.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class NewsHeaderCell: UICollectionViewCell {
    
    var headerNew1: PopularNews? {
        didSet {
            if let popularTitle = headerNew1?.title {
                title.text = popularTitle
                
                let size = CGSize(width: frame.width - 55, height: 1000)
                let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)]
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedFrame = NSString(string: popularTitle).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                
                let estimatedHeight = estimatedFrame.size.height
                
                if estimatedHeight > 17 {
                    titleHeightConstraint.constant = 20
                }
                if estimatedHeight > 35.8 {
                    titleHeightConstraint.constant = 36
                }
                
                
            }
            
            if let caption = headerNew1?.caption {
                subtitle.text = caption
            }
            if let section = headerNew1?.section {
                sectionLabel.text = section
            }
            
            if let headerImage = headerNew1?.imageURL {
                imageView.sd_setImage(with: URL(string: headerImage))
            }
        }
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "1."
        label.alpha = 0.8
        label.font = UIFont(name: "Avenir", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OPINION"
        label.text = "World"
        label.font = UIFont.systemFont(ofSize: 12)
        label.alpha = 0.5
        return label
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CapitalisTypOasis", size: 15)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let subtitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        label.textAlignment = .left
        label.alpha = 0.5
        label.font = UIFont(name: "Avenir", size: 13)
        return label
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 12)
        label.alpha = 0.6
        label.text = String(20.5)
        return label
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Upload-50"), for: .normal)
        return button
    }()
    
    let boobmarkButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(#imageLiteral(resourceName: "Bookmark Ribbon-50"), for: .normal)
        return button
    }()
    
    var titleHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        setupImage()
        setupPopularLabel()
        setupTitle()
        setupSectionLabel()
        setupSubtitle()
        setupTime()
        setupSeperatorView()
        setupShare()
        setupBookmark()
        bottomAnchor.constraint(equalTo: seperatorView.bottomAnchor).isActive = true
    }
    
    func setupImage() {
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: frame.height * 0.6).isActive = true
        imageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
    
    func setupPopularLabel() {
        addSubview(popularLabel)
        popularLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        popularLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        popularLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        popularLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupSectionLabel() {
        addSubview(sectionLabel)
        sectionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 7).isActive = true
        sectionLabel.leftAnchor.constraint(equalTo: title.leftAnchor).isActive = true
        sectionLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sectionLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupTitle() {
        addSubview(title)
        title.leftAnchor.constraint(equalTo: popularLabel.rightAnchor, constant: 10).isActive = true
        title.topAnchor.constraint(equalTo: popularLabel.bottomAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        
        titleHeightConstraint = title.heightAnchor.constraint(equalToConstant: 20)
        titleHeightConstraint.isActive = true
    }
    
    func setupSubtitle() {
        addSubview(subtitle)
        subtitle.leftAnchor.constraint(equalTo: title.leftAnchor).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5).isActive = true
        subtitle.rightAnchor.constraint(equalTo: title.rightAnchor).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 37).isActive = true
    }
    
    func setupSeperatorView() {
        addSubview(seperatorView)
        seperatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupTime() {
        addSubview(timeLabel)
        timeLabel.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0).isActive = true
        timeLabel.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 2).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupShare() {
        addSubview(shareButton)
        shareButton.rightAnchor.constraint(equalTo: title.rightAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    func setupBookmark() {
        addSubview(boobmarkButton)
        boobmarkButton.rightAnchor.constraint(equalTo: shareButton.leftAnchor, constant: -10).isActive = true
        boobmarkButton.bottomAnchor.constraint(equalTo: shareButton.bottomAnchor).isActive = true
        boobmarkButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        boobmarkButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
