//
//  NewsCell.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 21.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    
    var popularNews: PopularNews? {
        didSet {
            
            if let popularTitle = popularNews?.title {
                
                title.text = popularTitle
                let size = CGSize(width: frame.width - 162, height: 1000)
                let attributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)]
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedFrame = NSString(string: popularTitle).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                
                let estimatedHeight = estimatedFrame.size.height
                print(estimatedHeight, popularTitle)
                
                if estimatedHeight > 50 {
                    titleHeightConstraint.constant = 55
                } else if estimatedHeight > 33 {
                    titleHeightConstraint.constant = 40
                } else if estimatedHeight > 16 {
                    self.titleHeightConstraint.constant = 17
                }
                
            }
            
            if let caption = popularNews?.caption {
                
                subtitle.text = caption
                
                let size = CGSize(width: frame.width - 162, height: 1000)
                let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimatedFrame = NSString(string: caption).boundingRect(with: size, options: options, attributes: attributes, context: nil)
                
                let estimatedHeight = estimatedFrame.size.height

                if estimatedHeight > 143 {
                    captionHeightConstraint.constant = 132
                } else if estimatedHeight > 85 {
                    captionHeightConstraint.constant = 100
                } else if estimatedHeight > 71 {
                    captionHeightConstraint.constant = 85
                }
                else if estimatedHeight > 57 {
                    captionHeightConstraint.constant = 70
                }
                else if estimatedHeight > 42.9 {
                    captionHeightConstraint.constant = 50
                } else if estimatedHeight > 28 {
                    captionHeightConstraint.constant = 35
                }
                else if estimatedHeight > 14 {
                    captionHeightConstraint.constant = 17
                }
                
            } else {
                captionHeightConstraint.constant = 0
            }
            
            if let section = popularNews?.section {
                popularTypeLabel.text = section
            }
            if let views = popularNews?.views {
                popularLabel.text = "\(views)."
            }
            
            if let imageURL = popularNews?.imageURL {
                image.sd_setImage(with: URL(string: imageURL))
            }
            
        }
        
    }
    
    let popularLabel: UILabel = {
        let label = UILabel()
        label.text = "2."
        label.alpha = 0.8
        label.font = UIFont(name: "Avenir", size: 20)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let popularTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "OPINION"
        label.font = UIFont.systemFont(ofSize: 12)
        label.alpha = 0.5
        return label
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "TravelingTypewriter", size: 14)
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let subtitle: UILabel = {
        let tv = UILabel()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.numberOfLines = 0
        tv.textAlignment = .left
        tv.alpha = 0.5
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam fringilla quam nec accumsan ultrices."
        tv.font = UIFont(name: "Avenir", size: 12)
        return tv
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cia")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 12)
        label.alpha = 0.6
        label.text = String(19.5)
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
    
    let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    var titleHeightConstraint: NSLayoutConstraint!
    var captionHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        setupPopularLabel()
        setupTypeLabel()
        setupImage()
        setupTitle()
        setupSubtitle()
        setupTime()
        setupSeperatorView()
        setupShare()
        setupBookmark()
        bottomAnchor.constraint(equalTo: seperatorView.bottomAnchor).isActive = true
    }
    
    func setupPopularLabel() {
        addSubview(popularLabel)
        popularLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        popularLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        popularLabel.widthAnchor.constraint(equalToConstant: 32).isActive = true
        popularLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    func setupTypeLabel() {
        addSubview(popularTypeLabel)
        popularTypeLabel.leftAnchor.constraint(equalTo: popularLabel.rightAnchor).isActive = true
        popularTypeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        popularTypeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        popularTypeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupTitle() {
        addSubview(title)
        title.leftAnchor.constraint(equalTo: popularTypeLabel.leftAnchor).isActive = true
        title.topAnchor.constraint(equalTo: popularTypeLabel.bottomAnchor).isActive = true
        title.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -10).isActive = true
        
        titleHeightConstraint = title.heightAnchor.constraint(equalToConstant: 10)
        titleHeightConstraint.isActive = true
    }
    
    func setupSubtitle() {
        addSubview(subtitle)
        subtitle.leftAnchor.constraint(equalTo: title.leftAnchor).isActive = true
        subtitle.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        subtitle.widthAnchor.constraint(equalTo: title.widthAnchor).isActive = true
        
        captionHeightConstraint = subtitle.heightAnchor.constraint(equalToConstant: 70)
        captionHeightConstraint.isActive = true
    }
    
    func setupImage() {
        addSubview(image)
        image.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        image.topAnchor.constraint(equalTo: popularTypeLabel.topAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    func setupTime() {
        addSubview(timeLabel)
        timeLabel.leftAnchor.constraint(equalTo: title.leftAnchor, constant: 0).isActive = true
        timeLabel.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 3).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    func setupShare() {
        addSubview(shareButton)
        shareButton.rightAnchor.constraint(equalTo: image.rightAnchor).isActive = true
        shareButton.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setupSeperatorView() {
        addSubview(seperatorView)
        seperatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        seperatorView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 3).isActive = true
        seperatorView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
