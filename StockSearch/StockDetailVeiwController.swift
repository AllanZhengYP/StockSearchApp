//
//  StockDetailVeiwController.swift
//  StockSearch
//
//  Created by 郑杨平 on 4/23/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON
import CoreData


class StockDetailViewController: UIViewController {
  var stockDetail: Array<Dictionary<String, String>>?
  

  @IBOutlet weak var DetailTableContainer: UIView!
  @IBOutlet weak var WebviewContainer: UIView!
  @IBOutlet weak var NewsViewContainer: UIView!
  
  @IBOutlet weak var segmentControlBar: UISegmentedControl!

  @IBOutlet weak var navigationBar: UINavigationItem!

  @IBAction func touchSegmentedController(sender: AnyObject) {
    if segmentControlBar.selectedSegmentIndex == 0 {
      DetailTableContainer.hidden = false
      WebviewContainer.hidden = true
      NewsViewContainer.hidden = true
    }
    else if segmentControlBar.selectedSegmentIndex == 1 {
      DetailTableContainer.hidden = true
      WebviewContainer.hidden = false
      NewsViewContainer.hidden = true
      
    }
    else if segmentControlBar.selectedSegmentIndex == 2 {
      DetailTableContainer.hidden = true
      WebviewContainer.hidden = true
      NewsViewContainer.hidden = false
      
    }
  }
  
  override func viewDidLoad() {
    DetailTableContainer.hidden = false
    WebviewContainer.hidden = true
    NewsViewContainer.hidden = true
    
    self.navigationController?.navigationBarHidden = false
    self.navigationBar.title = stockDetail![1]["Symbol"]!
    
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    if segue.identifier == "sagueToDetailTable" && stockDetail != nil{
      let detail: DetailTableView = segue.destinationViewController as! DetailTableView
      detail.stockDetail = stockDetail
    }
    else if segue.identifier == "segueToWebview"  && stockDetail != nil {
      let symbol: Webview = segue.destinationViewController as! Webview
      symbol.stockSymbol = stockDetail![1]["Symbol"]!
    }
    else if segue.identifier == "segueToNewsView" && stockDetail != nil{
      let symbol: NewsTableView = segue.destinationViewController as! NewsTableView
      symbol.stockSymbol = stockDetail![1]["Symbol"]!
    }
    
  }
  
}



extension StockDetailViewController {
  }

extension StockDetailViewController {
  func webViewDidFinishLoad(webView: UIWebView) {
    let script = "$(function(){plotChart(\"" + stockDetail![1]["Symbol"]! + "\");});"
    webView.stringByEvaluatingJavaScriptFromString(script)
  }
}




