//
//  ContactDetailCell.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ContactDetailCell: UITableViewCell {
    
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var telLab: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
