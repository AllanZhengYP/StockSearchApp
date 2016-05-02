//
//  NewsTableCell.swift
//  StockSearch
//
//  Created by 郑杨平 on 5/1/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import UIKit

class NewsTableCell: UITableViewCell {

  @IBOutlet weak var newsTitle: UITextField!
  @IBOutlet weak var newsBody: UITextField!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
