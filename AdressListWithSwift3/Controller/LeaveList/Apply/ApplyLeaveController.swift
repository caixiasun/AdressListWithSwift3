//
//  ApplyLeaveController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ApplyLeaveController: UIViewController ,UITextFieldDelegate,LeaveListModelDelegate{
    
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var daysTextField: UITextField!
    
    var messageView:MessageView?
    var leaveModel = LeaveListModel()
    
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
        
        self.messageView = addMessageView(InView: self.view)
        self.leaveModel.delegate = self
        
        self.startTextField.becomeFirstResponder()
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
            self.submitAction()
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
        case TextFieldTagStyle.StartDate.rawValue://开始时间
            break
        case TextFieldTagStyle.EndDate.rawValue://结束时间
            break
        case TextFieldTagStyle.LeaveDays.rawValue://请假时长
            break
        case TextFieldTagStyle.LeaveReason.rawValue://请假原因
            break
        default:
            break
        }
    }
    
    func submitAction()
    {
        if (self.startTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "请输入开始时间!", Duration: 1)
            self.startTextField.becomeFirstResponder()
            return
        }
        if (self.endTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "请输入结束时间!", Duration: 1)
            self.endTextField.becomeFirstResponder()
            return
        }
        if (self.daysTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "请输入请假时长：天数!", Duration: 1)
            self.daysTextField.becomeFirstResponder()
            return
        }
        
        self.view.endEditing(true)
        
        var param = Dictionary<String, Any>()
        param[kToken] = dataCenter.getToken()
        param["started"] = self.startTextField.text
        param["ended"] = self.endTextField.text
        param["time"] = self.daysTextField.text
        if !(self.reasonTextView.text?.isEmpty)! {
            param["reason"] = self.reasonTextView.text
        }
        self.messageView?.setMessageLoading()
        self.leaveModel.requestLeaveApply(param: param)
    }
    
    //MARK: -LeaveListModelDelegate
    func requestLeaveApplySucc(success: SuccessData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: "申请已提交,请等待审核！", Duration: 1)
        perform(#selector(exitThisController), with: nil, afterDelay: 1.5)
        
    }
    func requestLeaveApplyFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    
}
