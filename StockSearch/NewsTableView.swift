//
//  NewsTableView.swift
//  StockSearch
//
//  Created by 郑杨平 on 5/2/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class NewsTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var stockSymbol: String?
  var newsData: Array<Dictionary<String, String>> = Array<Dictionary<String, String>>()
  override func viewDidLoad() {
    //load the news
    let queryResult = Alamofire.request(.GET, "http://steel-utility-127007.appspot.com", parameters: ["q": stockSymbol!]).responseJSON()
    let jsonData = JSON(data: queryResult.data!)
    if jsonData.count > 0 {
      newsData.removeAll()
      for var i = 0; i < jsonData["d"]["results"].array?.count; i += 1 {
        var news: Dictionary<String, String> = Dictionary<String, String>()
        news["Title"] = jsonData["d"]["results"][i]["Title"].string
        news["Url"] = jsonData["d"]["results"][i]["Url"].string
        news["Source"] = jsonData["d"]["results"][i]["Source"].string
        news["Description"] = jsonData["d"]["results"][i]["Description"].string
        news["Date"] = jsonData["d"]["results"][i]["Date"].string
        newsData.append(news)
        news.removeAll()
      }
    }

  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {      
    
    let newscell = tableView.dequeueReusableCellWithIdentifier("News", forIndexPath: indexPath) as! NewsTableCell
    newscell.newsTitle.text = newsData[indexPath.row]["Title"]
    newscell.newsBody.text = newsData[indexPath.row]["Description"]
    return newscell

  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return newsData.count
 
  }
}
