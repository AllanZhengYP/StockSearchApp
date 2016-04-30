//
//  StockDetailVeiwController.swift
//  StockSearch
//
//  Created by 郑杨平 on 4/23/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import Foundation
import UIKit

class StockDetailViewController: UIViewController {
  var stockDetail: Array<Dictionary<String, String>>?
  
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var segmentControlBar: UISegmentedControl!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBAction func touchSegmentedController(sender: AnyObject) {
    if segmentControlBar.selectedSegmentIndex == 0 {
      print(stockDetail![0]["Name"]!)
    }
    else if segmentControlBar.selectedSegmentIndex == 1 {
//      textLabel.text = "111111"
    }
    else if segmentControlBar.selectedSegmentIndex == 2 {
//      textLabel.text = "222222"
      
    }
  }
  
  
  
  override func viewDidLoad() {
    self.navigationController?.navigationBarHidden = false
  }
}

extension StockDetailViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//    let cell = DetailTableCell()
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
      cell.cellValue.text = stockDetail![0]["Name"]!
    case 4:
      cell.cellName.text = "Time and Date"
      cell.cellValue.text = stockDetail![0]["Name"]!
    case 5:
      cell.cellName.text = "Market Cap"
      cell.cellValue.text = stockDetail![0]["Name"]!
    case 6:
      cell.cellName.text = "Volume"
      cell.cellValue.text = stockDetail![0]["Name"]!
    case 7:
      cell.cellName.text = "ChangeYTD"
      cell.cellValue.text = stockDetail![0]["Name"]!
    case 8:
      cell.cellName.text = "High Price"
      cell.cellValue.text = stockDetail![0]["Name"]!
    case 9:
      cell.cellName.text = "Low Price"
      cell.cellValue.text = stockDetail![0]["Name"]!
    case 10:
      cell.cellName.text = "Opening Price"
      cell.cellValue.text = stockDetail![0]["Name"]!

    default:
      cell.textLabel?.text = "Key"
    }
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 11
  }
}
