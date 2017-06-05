//
//  slideMenu.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 24.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import Foundation

class SlideMenu: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let logOutCellId = "logOutCellId"
    var selectedIndex = -1
    
    var sections = [String]()
    var sectionImages = [UIImage]()
    
    var newsController: NewsVC?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupCollectionView()
        
        sections = ["Top Stories", "Most Popular", "Saved for Later", "Opinion", "Video", "World", "U.S.", "Politics", "The Upshot", "New York", "Business Day", "Technology", "Sciense", "Health", "Sports", "Arts", "Books", "Movies", "Theater", "Sunday Review", "Fashion & Style", "T Magazine", "Food", "Weddings", "Travel", "Magazine", "Real Estate", "Automobiles", "Obituaris", "Photos"]
        
        for section in sections {
            sectionImages.append(UIImage(named: section)!)
        }
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LogOutCell.self, forCellWithReuseIdentifier: logOutCellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuCell {
            
            if indexPath.item == sections.count {
                let logOutCell = collectionView.dequeueReusableCell(withReuseIdentifier: logOutCellId, for: indexPath) as! LogOutCell
                logOutCell.logOutButton.addTarget(self, action: #selector(showLogInController), for: .touchUpInside)
                return logOutCell
            }
            
            if indexPath.item == selectedIndex {
                cell.backgroundColor = .darkGray
                cell.sectionTitle.textColor = .white
            } else {
                cell.backgroundColor = .white
                cell.sectionTitle.textColor = .black
            }

            cell.sectionTitle.text = sections[indexPath.item]
            cell.imageView.image = sectionImages[indexPath.item]
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == sections.count {
            showLogInController()
        }
        self.selectedIndex = indexPath.item
        collectionView.reloadData()
        newsController?.hideMenu()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 47)
    }
    
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 66).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func showLogInController() {
        newsController?.showLogInController()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
