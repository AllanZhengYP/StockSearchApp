//
//  FavouriteTableCell.swift
//  StockSearch
//
//  Created by 郑杨平 on 5/3/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import Foundation
import UIKit
class FavouriteTableCell: UITableViewCell {
  
  @IBOutlet weak var symbol: UILabel!
  @IBOutlet weak var lastPrice: UILabel!
  @IBOutlet weak var change: UILabel!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var marketCap: UILabel!
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }

  
}
