//
//  PopularNews.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 21.5.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit

class PopularNews {
    
    private var _title: String!
    private var _caption: String!
    private var _date: Date!
    private var _url: String!
    private var _views: Int!
    private var _imageURL: String!
    private var _section: String!
    private var _keywords: String!
    private var _isRead: Bool!
    
    var isRead: Bool {
        if _isRead == nil {
            _isRead = false
        }
        return _isRead
    }
    
    var imageURL: String {
        if _imageURL == nil {
            _imageURL = ""
        }
        return _imageURL
    }
    
    var keywords: String {
        if _keywords == nil {
            _keywords = ""
        }
        return _keywords
    }
    
    var title: String {
        if _title == nil {
            _title = ""
        }
            return _title
    }
    
    var caption: String {
        if _caption == nil {
            _caption = ""
        }
        return _caption
    }
    
    var date: Date {
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: _date)
        let day = calendar.component(.day, from: _date)
        return _date
    }

    var url: String {
        if _url == nil {
             _url = ""
        }
        return _url
    }
    
    var views: Int {
        if _views == nil {
            _views = 0
        }
        return _views
    }
    
    var section: String {
        if _section == nil {
            _section = ""
        }
        return _section
    }
    
    init(title: String, caption: String, url: String, views: Int, section: String, keywords: String, imageURL: String, isRead: Bool) {
        _isRead = isRead
        _imageURL = imageURL
        _title = title
        _caption = caption
        _url = url
        _views = views
        _section = section
        _keywords = keywords
    }
    
    
}
