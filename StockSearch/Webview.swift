//
//  Webview.swift
//  StockSearch
//
//  Created by 郑杨平 on 5/2/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import Foundation
import UIKit
class Webview: UIViewController, UIWebViewDelegate {
  var stockSymbol: String?
  @IBOutlet weak var webView: UIWebView!
  
  override func viewDidLoad() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Webview.reloadWebview),name:"loadWeb", object: nil)
    let myPath = NSBundle.mainBundle().pathForResource("HistoricalChart", ofType: "html")
    webView.loadRequest(NSURLRequest(URL: NSURL(string: myPath!)!))
    webView.opaque = false
  }
  
  
  func webViewDidFinishLoad(webView: UIWebView) {
    let script = "$(function(){plotChart(\"" + stockSymbol! + "\");});"
    webView.stringByEvaluatingJavaScriptFromString(script)
  }
  
  func reloadWebview() {
    let myPath = NSBundle.mainBundle().pathForResource("HistoricalChart", ofType: "html")    
    webView.loadRequest(NSURLRequest(URL: NSURL(string: myPath!)!))

  }
  
}