//
//  LeaveDetailController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/9.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveDetailController: UIViewController {
    
    @IBOutlet weak var line1_height: NSLayoutConstraint!
    @IBOutlet weak var line2_height: NSLayoutConstraint!
    @IBOutlet weak var line3_height: NSLayoutConstraint!
    @IBOutlet weak var line4_height: NSLayoutConstraint!
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var telLab: UILabel!
    @IBOutlet weak var positionLab: UILabel!
    @IBOutlet weak var dateLab: UILabel!
    @IBOutlet weak var reasonLab: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
    }
    func initSubviews()
    {
        self.navigationItem.title = "请假详情"
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
        
        self.line1_height.constant = 0.5
        self.line2_height.constant = 0.5
        self.line3_height.constant = 0.5
        self.line4_height.constant = 0.5
        
        setCornerRadius(view: self.headImg, radius: kRadius_headImg_common)
        setBorder(view: self.headImg)
    }
    
    @IBAction func itemAction(sender: UIButton) {
        switch sender.tag {
        case 1://查看头像大图
            break
        case 2://拨打电话
            break
        default:
            break
        }
    }
    
}
