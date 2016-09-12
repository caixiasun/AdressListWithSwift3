//
//  LeaveDetailController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/9.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveDetailController: UIViewController {
    
    @IBOutlet weak var _line1_height: NSLayoutConstraint!
    @IBOutlet weak var _line2_height: NSLayoutConstraint!
    @IBOutlet weak var _line3_height: NSLayoutConstraint!
    @IBOutlet weak var _line4_height: NSLayoutConstraint!
    @IBOutlet weak var _headImg: UIImageView!
    @IBOutlet weak var _nameLab: UILabel!
    @IBOutlet weak var _telLab: UILabel!
    @IBOutlet weak var _positionLab: UILabel!
    @IBOutlet weak var _dateLab: UILabel!
    @IBOutlet weak var _reasonLab: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
    }
    func initSubviews()
    {
        self.navigationItem.title = "请假详情"
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
        
        _line1_height.constant = 0.5
        _line2_height.constant = 0.5
        _line3_height.constant = 0.5
        _line4_height.constant = 0.5
        
        setCornerRadius(view: _headImg, radius: kRadius_headImg_common)
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
