//
//  ModifyPasswordController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/30.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ModifyPasswordController: UIViewController ,MyModelDelegate{
    
    var messageView:MessageView?
    var myModel = MyModel()
    
    @IBOutlet weak var oldPsdTextField: UITextField!
    
    @IBOutlet weak var newPsdTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavi()
        
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
        
    }
    func initNavi()
    {
        self.navigationItem.title = "修改密码"
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = WhiteColor
        
        let saveBtn = YTDrawButton(title: kTitle_modify_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(ModifyPasswordController.modifyAction))
        saveBtn.tag = 1
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveBtn)
    }
    func modifyAction()
    {
        if (oldPsdTextField.text?.isEmpty)! || (newPsdTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "内容不能为空！", Duration: 1)
            return
        }
        var params = Dictionary<String, Any>()
        params[kToken] = dataCenter.getToken()
        params["old_password"] = oldPsdTextField.text
        params["new_password"] = newPsdTextField.text
        self.messageView?.setMessageLoading()
        self.myModel.requestModifyPassword(params: params)
    }
    //MARK: - MyModelDelegate
    func requestModifyPasswordSucc(success: SuccessData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: "密码修改成功！", Duration: 1)
        perform(#selector(exitThisController), with: nil, afterDelay: 1.5)
    }
    func requestModifyPasswordFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    
    func exitThisController()
    {
        dismiss(animated: true) {
            self.navigationController?.popViewController(animated: false)
        }
        
        appDelegate.setTabBarSelectViewController(index: 0)
        appDelegate.loadLoginVC()
    }

}
