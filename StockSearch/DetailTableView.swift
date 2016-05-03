//
//  DetailTableView.swift
//  StockSearch
//
//  Created by 郑杨平 on 5/2/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import Foundation
import UIKit
class DetailTableView: UIViewController, UITableViewDelegate, UITableViewDataSource {
  var stockDetail: Array<Dictionary<String, String>>?
  
  @IBOutlet weak var yahooChartView: UIImageView!
  @IBOutlet weak var detailTable: UITableView!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  
  override func viewDidLoad() {
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
      cell.cellValue.text = "$ " + String(round(Double(stockDetail![2]["LastPrice"]!)! * 100) / 100)
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
      cell.cellValue.text = "$ " + String(round(Double(stockDetail![11]["High"]!)! * 100) / 100)
    case 9:
      cell.cellName.text = "Low Price"
      cell.cellValue.text = "$ " + String(round(Double(stockDetail![12]["Low"]!)! * 100) / 100)
    case 10:
      cell.cellName.text = "Opening Price"
      cell.cellValue.text = "$ " + String(round(Double(stockDetail![13]["Open"]!)! * 100) / 100)
      
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

  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 11
  }
  
}