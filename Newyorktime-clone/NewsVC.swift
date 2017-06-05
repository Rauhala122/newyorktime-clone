//
//  ViewController.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 20.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Alamofire
import SwipeCellKit

class NewsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate {

    var selectedIndex = -1
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    var isMenuHidden = true
    
    var popularNews = [PopularNews]()
    
    var headerNew: PopularNews!
    var isCollectioviewHideGesture = false
    
    lazy var slideMenu: SlideMenu = {
        let menu = SlideMenu()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.newsController = self
        return menu
    }()
    
    let menuSeperator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.6, alpha: 1)
        return view
    }()
    
    lazy var newsController: ReadVC = {
        let controller = ReadVC()
        controller.newsController = self
        return controller
    }()
    
    var slideMenuWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame.height)
        popularNews = []
        collectionView?.backgroundColor = .white
        collectionView?.register(NewsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.register(NewsHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        navigationItem.title = "Popular News"
        let notifButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Appointment Reminders-25"), style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = notifButton
        
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menuBar"), style: .plain, target: self, action: #selector(handleMenuButton))
        navigationItem.leftBarButtonItem = menuButton
        navigationController?.navigationBar.tintColor = .black
        
        setupMenu()
        setupLineView()
        
        fetchPopularNews()
        fetchNewsHeader()
    }
    
    func swipeLeft() {
        hideMenu()
    }
    
    func swipeRight() {
        showMenu()
    }
    
    func handleMenuButton() {
        if isMenuHidden {
            showMenu()
        } else {
            hideMenu()
        }
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.slideMenuWidthConstraint.constant = -2
            self.isMenuHidden = true
            self.view.layoutIfNeeded()
            print(self.isMenuHidden)
        })
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.slideMenuWidthConstraint.constant = self.view.frame.width - 75
            self.isMenuHidden = false
            self.view.layoutIfNeeded()
        })
    }
    
    func handleBack() {
        dismiss(animated: true, completion: nil)
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularNews.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? NewsCell {
            
            if selectedIndex == indexPath.item {
                UIView.animate(withDuration: 0.2, animations: { 
                    cell.backgroundColor = .darkGray
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: { 
                    cell.backgroundColor = .white
                })
            }
            
            let popularNews = self.popularNews[indexPath.item]
            cell.popularNew = popularNews
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        collectionView.reloadData()
        
        let news = popularNews[indexPath.item]
        
        let readController = ReadVC()
        readController.transitioningDelegate = self
        readController.interactor = interactor
        readController.news = news
        readController.newsController = self
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(readController, animated: true)
    }
    
    func handleDismiss() {
        self.selectedIndex = -1
        self.collectionView?.reloadData()
 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let news = popularNews[indexPath.item]
        
        let size = CGSize(width: view.frame.width - 162, height: 100)
        let sectionRect = NSString(string: news.caption).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)], context: nil)
        let titleRect = NSString(string: news.title).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        let captionRect = NSString(string: news.caption).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)], context: nil)
        
        let estimatedRect = titleRect.size.height + captionRect.size.height + sectionRect.size.height
        
        let height: CGFloat?
        if estimatedRect > 221 {
            height = 3
        } else if estimatedRect > 202 {
            height = 5
        } else if estimatedRect > 193 {
            height = 12
        } else if estimatedRect > 164 {
            height = 14
        } else if estimatedRect > 136 {
            height = 22
        } else if estimatedRect > 119 {
            height = 47
        } else if estimatedRect > 107 {
            height = 60
        } else if estimatedRect > 78 {
            height = 38
        } else if estimatedRect > 59 {
            height = 62
        } else if estimatedRect > 45 {
            height = 70
        }else {
            height = 20
        }
        
        print(estimatedRect, news.title)
        
        return CGSize(width: collectionView.frame.width, height: estimatedRect + height!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! NewsHeaderCell
            header.headerNew1 = headerNew
            return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.55)
    }
    
    
    func fetchPopularNews() {
        ApiService.sharedInstance.fetchNews(url: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=7ac2bf9ba0834417aad5c682c9714eb4", isHeader: false, image: 2) { (popularNews: [PopularNews]) in
            self.popularNews = popularNews
            self.collectionView?.reloadData()
        }
    }
    
    func fetchNewsHeader() {
        ApiService.sharedInstance.fetchNews(url: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/1.json?api-key=7ac2bf9ba0834417aad5c682c9714eb4", isHeader: true, image: 5) { (headerNews: [PopularNews]) in
            self.headerNew = headerNews[0]
            self.collectionView?.reloadData()
        }
        
    }
    
    func setupMenu() {
        view.addSubview(slideMenu)
        slideMenu.leftAnchor.constraint(equalTo: view.leftAnchor, constant: -2).isActive = true
        slideMenu.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        slideMenuWidthConstraint = slideMenu.widthAnchor.constraint(equalToConstant: 0)
        slideMenuWidthConstraint.isActive = true
        
        slideMenu.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func setupLineView() {
        view.addSubview(menuSeperator)
        menuSeperator.leftAnchor.constraint(equalTo: slideMenu.rightAnchor).isActive = true
        menuSeperator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuSeperator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        menuSeperator.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    let interactor = Interactor()

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?  {
        return DismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func showLogInController() {
        let logInController = LoginController()
        present(logInController, animated: true, completion: nil)
    }
    

    
}

