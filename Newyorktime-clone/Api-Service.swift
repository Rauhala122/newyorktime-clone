//
//  Api-Service.swift
//  Newyorktime-clone
//
//  Created by Saska Rauhala on 5.6.2017.
//  Copyright © 2017 SarTekh. All rights reserved.
//

import UIKit
import Alamofire

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchNews(url: String, isHeader: Bool, image: Int, completion: @escaping ([PopularNews]) ->()) {
        
        var popularNews = [PopularNews]()
        var headerNews = [PopularNews]()
        
        Alamofire.request(url).responseJSON { (response) in
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
                                                            let header = PopularNews(title: title, caption: caption, url: url, views: views, section: section, keywords: keywords, imageURL: image, isRead: false)
                                                            headerNews.append(header)
                                                            } else {
                                                            let popularnew = PopularNews(title: title, caption: caption, url: url, views: views, section: section, keywords: keywords, imageURL: image, isRead: false)
                                                            
                                                            popularNews.append(popularnew)
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
                if isHeader {
                    completion(headerNews)
                } else {
                    completion(popularNews)
                }
            }
        }
    }
}

