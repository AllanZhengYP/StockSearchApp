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
  @IBOutlet weak var segmentControlBar: UISegmentedControl!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBAction func touchSegmentedController(sender: AnyObject) {
    if segmentControlBar.selectedSegmentIndex == 0 {
      scrollView.hidden = true
    }
    else if segmentControlBar.selectedSegmentIndex == 1 {
      
    }
    else if segmentControlBar.selectedSegmentIndex == 2 {
      
    }
  }
  override func viewDidLoad() {
    self.navigationController?.navigationBarHidden = false
  }


}