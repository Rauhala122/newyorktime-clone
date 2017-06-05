//
//  LoginController.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 31.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let loginCell = "loginCell"
    
    var pages: [Page] = {
        
        let page1 = Page(imageName: "page1", title: "Read Great News", message: "Start Reading New York Times News Now For Just 15€ in a month.")
        let page2 = Page(imageName: "page2", title: "Browse News", message: "Browse News In the Application On Various Topics.")
        let page3 = Page(imageName: "page3", title: "Read News", message: "Read News In the application Just by Pressing The News.")
        let page4 = Page(imageName: "page4", title: "Share News", message: "Share Interesting News by Pressing the Share Button Below The News.")
        
        return [page1, page2, page3, page4]
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let pageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.numberOfPages = 5
        return pageControl
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Skip", for: .normal)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        return button
    }()
    
    var nextButtonTopAnchor: NSLayoutConstraint!
    var skipButtonTopAnchor: NSLayoutConstraint!
    var pageControllerBottomAnchor: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCell)
        setCollectionView()
        setPageControl()
        setNextButton()
        setSkipButton()
    }
    
    func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func setPageControl() {
        view.addSubview(pageController)
        pageController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
       
        pageControllerBottomAnchor = pageController.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        pageControllerBottomAnchor.isActive = true
        
        pageController.heightAnchor.constraint(equalToConstant: 30).isActive = true
        pageController.widthAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    func setNextButton() {
        view.addSubview(nextButton)
        nextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        
        nextButtonTopAnchor = nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        nextButtonTopAnchor.isActive = true
        
        nextButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setSkipButton(){
        view.addSubview(skipButton)
        skipButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        
        skipButtonTopAnchor = skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        skipButtonTopAnchor.isActive = true
        
        skipButton.widthAnchor.constraint(equalToConstant: 35).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    func handleNext() {
        if pageController.currentPage == pages.count - 1 {
            hideElements()
        }
        handleButtons(index: pageController.currentPage + 1)
    }
    
    func handleSkip() {
        handleButtons(index: pages.count)
        hideElements()
        
        collectionView.isUserInteractionEnabled = false
        let dismiss = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: dismiss){
            self.collectionView.isUserInteractionEnabled = true
        }
    }
    
    func handleButtons(index: Int) {
        let indexPath = NSIndexPath(item: index , section: 0)
        pageController.currentPage = index
        collectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    func presentNewsController() {
        let layout = UICollectionViewFlowLayout()
        let newsController = NewsVC(collectionViewLayout: layout)
        present(UINavigationController(rootViewController: newsController), animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if indexPath.item == pages.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCell, for: indexPath) as! LoginCell
            cell.loginController = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = targetContentOffset.pointee.x / 375
        
        pageController.currentPage = Int(pageNumber)
        
        if Int(pageNumber) == pages.count {
            hideElements()
        } else {
            showElements()
            self.view.endEditing(true)
        }
    }
    
    func hideElements() {
        UIView.animate(withDuration: 0.2) {
            self.nextButtonTopAnchor.constant = -30
            self.skipButtonTopAnchor.constant = -30
            self.pageControllerBottomAnchor.constant = 30
            self.view.layoutIfNeeded()
        }
    }
    
    func showElements() {
        UIView.animate(withDuration: 0.2) {
            self.nextButtonTopAnchor.constant = 20
            self.skipButtonTopAnchor.constant = 20
            self.pageControllerBottomAnchor.constant = -20
            self.view.layoutIfNeeded()
        }
    }
}
