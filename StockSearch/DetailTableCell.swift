//
//  DetailTableCell.swift
//  StockSearch
//
//  Created by 郑杨平 on 4/29/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import UIKit

class DetailTableCell: UITableViewCell {
  
  @IBOutlet weak var cellImg: UIImageView!
  @IBOutlet weak var cellName: UILabel!
  @IBOutlet weak var cellValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
