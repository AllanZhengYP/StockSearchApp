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
  @IBOutlet weak var newsListTable: UITableView!
  var stockSymbol: String?
  var newsData: Array<Dictionary<String, String>> = Array<Dictionary<String, String>>()
  override func viewDidLoad() {
    loadNews()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewsTableView.loadNews),name:"loadNews", object: nil)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {      
    
    let newscell = tableView.dequeueReusableCellWithIdentifier("News", forIndexPath: indexPath) as! NewsTableCell
    newscell.newsTitle.text = newsData[indexPath.row]["Title"]
    newscell.newsBody.text = newsData[indexPath.row]["Description"]
    newscell.newsPulisher.text = newsData[indexPath.row]["Source"]
    
//    //convert the date
//    let dateFormatter = NSDateFormatter()
//    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
//    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
//    let date = dateFormatter.dateFromString( newsData[indexPath.row]["Date"]!)
//    let outputFormatter = NSDateFormatter()
//    outputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//    let convertedDate = outputFormatter.stringFromDate(date!)
    
    newscell.newsDate.text = newsData[indexPath.row]["Date"]

    
    return newscell

  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return newsData.count
 
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    let rowIndex = indexPath.row
    if let checkURL = NSURL(string: newsData[rowIndex]["Url"]!) {
      UIApplication.sharedApplication().openURL(checkURL)
    }
  }
  
}


extension NewsTableView {
  //load the news
  func loadNews() {
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
    newsListTable.reloadData()
  }

}
