//
//  LeaveCell.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveCell: UICollectionViewCell {
    
    
    @IBOutlet weak var headImgHeight: NSLayoutConstraint!
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var flagImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setCornerRadius(view: self, radius: 10)
        self.layer.borderColor = MainColor.cgColor;
        self.layer.borderWidth = 0.5
        setCornerRadius(view: headImg, radius: 10)
    }
    
    func setContent(data:LeaveListData)
    {
        self.nameLab.text = data.name
        if data.head_img != nil && !(data.head_img?.isEmpty)! {
            self.headImg.sd_setImage(with: URL(string: data.head_img!), placeholderImage: UIImage(named: "head.png"))
        }
    }

}
