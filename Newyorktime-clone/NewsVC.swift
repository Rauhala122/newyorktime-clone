//
//  ViewController.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 20.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Alamofire

class NewsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let headerId = "headerId"
    
    var isMenuHidden = true
    
    var popularNews = [PopularNews]()
    
    var headerNew: PopularNews!
    
    let slideMenu: SlideMenu = {
        let menu = SlideMenu()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.isHidden = true
        return menu
    }()
    
    var slideMenuWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(NewsHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        navigationItem.title = "Popular News"
        let notifButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Appointment Reminders-25"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = notifButton
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menuBar"), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.leftBarButtonItem = menuButton
        navigationController?.navigationBar.tintColor = .black
        
        setupMenu()
        
        dowloadPopularestNews(url: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=7ac2bf9ba0834417aad5c682c9714eb4", isHeader: true, image: 3)
        dowloadPopularestNews(url: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=7ac2bf9ba0834417aad5c682c9714eb4", isHeader: false, image: 2)
    }
    
    func handleMenu() {
        
        if isMenuHidden {
            UIView.animate(withDuration: 0.2, animations: {
                self.slideMenuWidthConstraint.constant = 220
                self.slideMenu.isHidden = false
                self.view.layoutIfNeeded()
            })
        }
        
        if !isMenuHidden {
            UIView.animate(withDuration: 0.2, animations: {
                self.slideMenuWidthConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
        
        isMenuHidden = !isMenuHidden
    
    }
    
    func handleBack() {
        dismiss(animated: true, completion: nil)
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularNews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? NewsCell {
            
            let popularNews = self.popularNews[indexPath.item]
            cell.popularNews = popularNews
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let title = popularNews[indexPath.item].title
        let caption = popularNews[indexPath.item].caption
        
        let size = CGSize(width: view.frame.width - 162 , height: 100)
        let attributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
        
        let estimatedFrame = NSString(string: title).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let estimatedHeight = estimatedFrame.size.height
        
        let size2 = CGSize(width: view.frame.width - 162, height: 1000)
        let attributes2 = [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        let options2 = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let captionFrame = NSString(string: caption).boundingRect(with: size2, options: options2, attributes: attributes, context: nil)
        let captionHeight = captionFrame.size.height
        
        return CGSize(width: collectionView.frame.width, height: captionHeight + estimatedHeight + 60)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! NewsHeaderCell
            header.headerNew1 = headerNew
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.55)
    }
    
    func dowloadPopularestNews(url: String, isHeader: Bool, image: Int) {
        
        Alamofire.request(url).responseJSON { (response) in
            
            self.popularNews = []
            
            if let dict = response.value as? Dictionary<String, AnyObject> {
                if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                    
                    var starting: Int!
                    var ending: Int!
                    
                    if !isHeader {
                        starting = 1
                        ending = results.count
                    } else {
                        starting = 0
                        ending = 1
                    }
                    
                    for i in starting..<ending {
                        
                        if let url = results[i]["url"] as? String {
                            if let keywords = results[i]["adx_keywords"] as? String {
                                if let section = results[i]["section"] as? String {
                                    if let title = results[i]["title"] as? String {
                                        if let views = results[i]["views"] as? Int {
                                            if let media = results[i]["media"] as? [Dictionary<String, AnyObject>] {
                                                if let caption = media[0]["caption"] as? String {
                                                
                                                if let mediaData = media[0]["media-metadata"] as? [Dictionary<String, AnyObject>] {
                                                    if let image = mediaData[image]["url"] as? String {
                                                        
                                                        if isHeader {
                                                            let popularnew = PopularNews(title: title, caption: caption, url: url, views: views, section: section, keywords: keywords, imageURL: image)
                                                                self.headerNew = popularnew
                                                                self.collectionView?.reloadData()
                                                            } else {
                                                                let popularnew = PopularNews(title: title, caption: caption, url: url, views: views, section: section, keywords: keywords, imageURL: image)
                                                            
                                                                self.popularNews.append(popularnew)
                                                                self.collectionView?.reloadData()
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        
                    }
                }
            }
            
        }
        
    }
    
    func setupMenu() {
        view.addSubview(slideMenu)
        slideMenu.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        slideMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        
        slideMenuWidthConstraint = slideMenu.widthAnchor.constraint(equalToConstant: 0)
        slideMenuWidthConstraint.isActive = true
        
        slideMenu.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
}

