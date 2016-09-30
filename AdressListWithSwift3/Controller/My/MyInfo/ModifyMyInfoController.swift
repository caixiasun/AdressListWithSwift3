//
//  ModifyMyInfoController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/30.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ModifyMyInfoController: UIViewController,MyModelDelegate{
    
    @IBOutlet weak var textField: UITextField!
    var naviTitle:String?
    var textFieldText:String?
    var messageView:MessageView?
    var myModel = MyModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
    }

    func initNavi()
    {
        self.navigationItem.title = "修改" + naviTitle!
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = WhiteColor
        
        let saveBtn = YTDrawButton(title: kTitle_save_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(ModifyMyInfoController.saveAction))
        saveBtn.tag = 1
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveBtn)
    }

    func initSubviews()
    {
        self.initNavi()
        
        self.textField.becomeFirstResponder()
        self.textField.text = textFieldText
        
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
    }
    //MARK: - action method
    func saveAction()
    {
        if naviTitle != "昵称" && (textField.text?.isEmpty)!{
            self.messageView?.setMessage(Message: "\(naviTitle)不能为空！", Duration: 1)
            return
        }
        var key = ""
        if naviTitle == "昵称" {
            key = "nickname"
        }else if naviTitle == "姓名"{
            key = "name"
        }else if naviTitle == "电话"{
            key = "mobile"
        }else if naviTitle == "邮箱"{
            key = "email"
        }
        var params = Dictionary<String, Any>()
        params[kToken] = dataCenter.getToken()
        params[key] = self.textField.text
        self.messageView?.setMessageLoading()
        self.myModel.requestEditMyInfo(params: params)
        
    }
    //MARK: -MyModelDelegate
    func requestEditMyInfoSucc(success: SuccessData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: "修改成功！", Duration: 1)
        perform(#selector(ModifyMyInfoController.exitThisController), with: nil, afterDelay: 2)
        
    }
    func requestEditMyInfoFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    func exitThisController()
    {
        self.navigationController?.popViewController(animated: true)
    }
}
