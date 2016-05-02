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


class StockDetailViewController: UIViewController, UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource {
  var stockDetail: Array<Dictionary<String, String>>?
//  var newsData: Dictionary<String, Dictionary<String, Array<Dictionary<String, String>>>>?
  var newsData: Array<Dictionary<String, String>>?
  @IBOutlet weak var yahooChartView: UIImageView!
  @IBOutlet weak var detailTable: UITableView!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var segmentControlBar: UISegmentedControl!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var navigationBar: UINavigationItem!
  @IBOutlet weak var newsTable: UITableView!
  @IBOutlet weak var webView: UIWebView!
  @IBAction func touchSegmentedController(sender: AnyObject) {
    if segmentControlBar.selectedSegmentIndex == 0 {
      scrollView.hidden = false
      detailTable.hidden = false
      webView.hidden = true
      newsTable.hidden = true
    }
    else if segmentControlBar.selectedSegmentIndex == 1 {
      scrollView.hidden = true
      detailTable.hidden = true
      webView.hidden = false
      newsTable.hidden = true
      
      let myPath = NSBundle.mainBundle().pathForResource("HistoricalChart", ofType: "html")
      webView.delegate = self //For webViewDidFinishLoad to be called
      webView.loadRequest(NSURLRequest(URL: NSURL(string: myPath!)!))
    }
    else if segmentControlBar.selectedSegmentIndex == 2 {
      scrollView.hidden = true
      detailTable.hidden = true
      webView.hidden = true
      newsTable.hidden = false
      
    }
  }

  
  override func viewDidLoad() {
    
    self.navigationController?.navigationBarHidden = false
    self.navigationBar.title = stockDetail![1]["Symbol"]!
    
    scrollView.hidden = false
    detailTable.hidden = false
    webView.hidden = true
    newsTable.hidden = true
//    self.newsTable.delegate = self
//    self.newsTable.dataSource = self
    
  }
  
}

extension StockDetailViewController {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if stockDetail == nil {
      return UITableViewCell()
    }
    
    else if tableView == self.detailTable {
      let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DetailTableCell
      switch indexPath.row {
      case 0:
        cell.cellName.text = "Name"
        cell.cellValue.text = stockDetail![0]["Name"]!
      case 1:
        cell.cellName.text = "Symbol"
        cell.cellValue.text = stockDetail![1]["Symbol"]!
      case 2:
        cell.cellName.text = "Last Price"
        cell.cellValue.text = "$ " + stockDetail![2]["LastPrice"]!
      case 3:
        cell.cellName.text = "Change"
        let change = round(Double(stockDetail![3]["Change"]!)! * 100) / 100
        let changePercent = round(Double(stockDetail![4]["ChangePercent"]!)! * 100) / 100
        cell.cellValue.text = String(change) + "(" + String(changePercent) + "%)"
        if (change > 0) {
          cell.cellImg.image = UIImage(named: "Up-52.png")
        } else {
          cell.cellImg.image = UIImage(named: "Down-52.png")
        }
      case 4:
        cell.cellName.text = "Time and Date"
        //      cell.cellValue.text = stockDetail![0]["Name"]!
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        //      dateFormatter.timeZone = NSTimeZone()
        let date = dateFormatter.dateFromString(stockDetail![5]["Timestamp"]!)
        let outputFormatter = NSDateFormatter()
        outputFormatter.dateFormat = "MMM d yyyy HH:mm"
        let convertedDate = outputFormatter.stringFromDate(date!)
        cell.cellValue.text = convertedDate
      case 5:
        cell.cellName.text = "Market Cap"
        let cap = Double(stockDetail![7]["MarketCap"]!)
        let capStr: String?
        if cap > 1000_000_000 {
          capStr = String(round(cap! / 1000_000_000 * 100) / 100) + " Billion"
          cell.cellValue.text = capStr
        }
        else if cap > 1000_000 {
          capStr = String(round(cap! / 1000_000 * 100) / 100) + " Million"
          cell.cellValue.text = capStr
        }
        else {
          capStr = String(round(cap! * 100) / 100)
          cell.cellValue.text = capStr
        }
      case 6:
        cell.cellName.text = "Volume"
        cell.cellValue.text = String(Int(Double(stockDetail![8]["Volume"]!)!))
      case 7:
        cell.cellName.text = "ChangeYTD"
        let changeYTD = round(Double(stockDetail![9]["ChangeYTD"]!)! * 100) / 100
        let changePercentYTD = round(Double(stockDetail![10]["ChangePercentYTD"]!)! * 100) / 100
        cell.cellValue.text = String(changeYTD) + "(" + String(changePercentYTD) + "%)"
        if (changePercentYTD > 0) {
          cell.cellImg.image = UIImage(named: "Up-52.png")
        } else {
          cell.cellImg.image = UIImage(named: "Down-52.png")
        }
      case 8:
        cell.cellName.text = "High Price"
        cell.cellValue.text = "$ " + stockDetail![11]["High"]!
      case 9:
        cell.cellName.text = "Low Price"
        cell.cellValue.text = "$ " + stockDetail![12]["Low"]!
      case 10:
        cell.cellName.text = "Opening Price"
        cell.cellValue.text = "$ " + stockDetail![13]["Open"]!
        
      default:
        cell.textLabel?.text = "Key"
      }
      
      if (stockDetail != nil) && (stockDetail![1]["Symbol"] != nil) {
        let imgURL: String = "http://chart.finance.yahoo.com/t?s="+stockDetail![1]["Symbol"]!+"&lang=en-US&width=480&height=350"
        if let url:NSURL = NSURL(string: imgURL)! {
          if let data = NSData(contentsOfURL: url) {
            yahooChartView.image = UIImage(data: data)
          }
        }
      }
      
      return cell
    }
    
    else if tableView == self.newsTable {
      let newscell = tableView.dequeueReusableCellWithIdentifier("News", forIndexPath: indexPath) as! NewsTableCell
      newscell.newsTitle.text = newsData?[indexPath.row]["Title"]
      newscell.newsBody.text = newsData?[indexPath.row]["Description"]
      return newscell
    }
    return UITableViewCell()
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableView == self.detailTable {
      return 11
    }
    else if tableView == self.newsTable {
      return (newsData?.count)!
    }
    return 0
  }
}

extension StockDetailViewController {
  func webViewDidFinishLoad(webView: UIWebView) {
    let script = "$(function(){plotChart(\"" + stockDetail![1]["Symbol"]! + "\");});"
    webView.stringByEvaluatingJavaScriptFromString(script)
  }
}

