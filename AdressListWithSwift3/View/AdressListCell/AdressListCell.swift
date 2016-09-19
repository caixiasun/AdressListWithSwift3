//
//  AdressListCell.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class AdressListCell: UITableViewCell {
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var flagImg: UIImageView!//图片标记：请假状态

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContent(data:UserData)
    {
        self.nameLab.text = data.name
    }
    
}
