//
//  ReadVC.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 26.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class ReadVC: UIViewController {
    
    var interactor:Interactor? = nil
    
    var newsController: NewsVC?
    
    var news: PopularNews? {
        didSet {
            if news != nil {
                newsUrl.loadRequest(URLRequest(url: URL(string: (news?.url)!)!))
            }
        }
    }
    
    let newsUrl: UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instantiatePanGestureRecognizer(self, #selector(gesture))
        setupWebview()
        navigationItem.title = "Popular News"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        newsController?.handleDismiss()
    }

    func setupWebview() {
        view.addSubview(newsUrl)
        newsUrl.topAnchor.constraint(equalTo: view.topAnchor)     .isActive = true
        newsUrl.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        newsUrl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newsUrl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    func gesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        dismissVCOnPanGesture(self, sender, interactor!)
    }
    
}
