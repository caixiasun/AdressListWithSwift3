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
    var phone:String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setContent(data:AnyObject)
    {
        if data.isKind(of: UserData.classForCoder()) {
            let newData = data as! UserData
            self.nameLab.text = newData.name
            self.phone = newData.tel
        }
        
        if data.isKind(of: LeaveListData.classForCoder()) {
            let newData = data as! LeaveListData
            self.nameLab.text = newData.name
            self.phone = newData.tel
            var imgName = "leaved.png"
            switch newData.status {
            case 0://0:待审核
                
                break
            case 1://1:已通过
                imgName = "leaveing.png"
                break
            case 2://2:未通过
                break
            default:
                break
            }
            self.flagImg.isHidden = false
            self.flagImg.image = UIImage(named: imgName)
            
            return
        }
        
        
    }
    
}
