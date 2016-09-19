//
//  ApplyLeaveController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ApplyLeaveController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var reasonTextView: UITextView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubview()
        
    }
    func initSubview()
    {
        self.initNaviBar()
        
        
        reasonTextView.text = "请假理由"
        reasonTextView.layer.borderColor = LineColor.cgColor
        reasonTextView.layer.borderWidth = 0.5
        setCornerRadius(view: reasonTextView, radius: 10)
    }
    func initNaviBar()
    {
        self.navigationItem.title = "请假申请"
        
        let cancelBtn = YTDrawButton(title: kTitle_cancel_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(ApplyLeaveController.itemAction(sender:)))
        cancelBtn.tag = 1
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        let doneBtn = YTDrawButton(title: kTitle_submit_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(ApplyLeaveController.itemAction(sender:)))
        doneBtn.tag = 2
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
    }
    func itemAction(sender:UIButton)
    {
        switch sender.tag {
        case 1://cancel
            exitThisController()
            break
        case 2://Submit 提交申请
            exitThisController()
            break
        default:
            break
        }
    }
    func exitThisController()
    {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case TextFieldTagStyle.Name.rawValue://姓名
            break
        case TextFieldTagStyle.Telephone.rawValue://电话
            break
        case TextFieldTagStyle.Position.rawValue://职位
            break
        case TextFieldTagStyle.LeaveDate.rawValue://请假时间
            break
        case TextFieldTagStyle.LeaveReason.rawValue://请假原因
            break
        default:
            break
        }
    }
    
}
