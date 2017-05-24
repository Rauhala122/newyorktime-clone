//
//  CategoriesVC.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 22.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit


class CategoriesVC: UIViewController  {
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.placeholder = "Search News"
        sb.backgroundColor = .red
        return sb
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .black
        setupSearchBar()
    }
    
    
    func setupSearchBar() {
        view.addSubview(searchBar)
        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
}
