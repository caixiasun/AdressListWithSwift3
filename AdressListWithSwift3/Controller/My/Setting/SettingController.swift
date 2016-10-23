//
//  SettingController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class SettingController: UIViewController ,MyModelDelegate{

    var messageView:MessageView?
    var myModel = MyModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavibar()
        
        self.setupUI()
    }
    func setupUI() {
        weak var blockSelf = self
        let modifyBtn = YTButton()
        modifyBtn.setPosition(top: kScreenHeight*0.3, left: 45, right: 45)
        modifyBtn.tag = 2
        modifyBtn.setTitle(title: "修改密码")
        modifyBtn.callBack = {(tag) in
            blockSelf?.buttonAction(tag: tag)
        }
        self.view.addSubview(modifyBtn)
        let loginoutBtn = YTButton()
        loginoutBtn.setPosition(top: getYTBottom(obj: modifyBtn)+30, left: 45, right: 45)
        loginoutBtn.tag = 1
        loginoutBtn.setTitle(title: "退出登录")
        loginoutBtn.setTitleColor(color:RedColor)
        loginoutBtn.callBack = {(tag) in
            blockSelf?.buttonAction(tag: tag)
        }
        self.view.addSubview(loginoutBtn)
        
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
    }
    func initNavibar()
    {
        self.navigationItem.title = "设置"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
    }
    
    func buttonAction(tag:Int) {
        if tag == 1 {
            //tag=1：退出登录
            self.messageView?.setMessage(Message: "退出登录成功！", Duration: 1)
            dataCenter.setLoginout()
            perform(#selector(changeTabBarController), with: nil, afterDelay: 1.5)
        }else{//修改密码
            self.navigationController?.pushViewController(ModifyPasswordController(), animated: true)
        }
    }

    func changeTabBarController()
    {
        dismiss(animated: true) { 
            self.navigationController?.popViewController(animated: false)
        }
        
        appDelegate.setTabBarSelectViewController(index: 0)
        appDelegate.loadLoginVC()
    }
    

}
