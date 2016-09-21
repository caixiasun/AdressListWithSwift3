//
//  SettingCell.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    @IBOutlet weak var dicatorImg: UIImageView!    
    @IBOutlet weak var titleLab: UILabel!
    
    func setContent()
    {
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
