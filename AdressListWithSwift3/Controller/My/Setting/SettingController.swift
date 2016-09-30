//
//  SettingController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class SettingController: UIViewController ,MyModelDelegate{

    
    @IBOutlet weak var modifyPasswordBtn: UIButton!
    @IBOutlet weak var loginoutBtn: UIButton!
    var messageView:MessageView?
    var myModel = MyModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavibar()
        
        self.view.backgroundColor = PageGrayColor
        setCornerRadius(view: self.loginoutBtn, radius: 5)
        setBorder(view: self.loginoutBtn)
        setCornerRadius(view: self.modifyPasswordBtn, radius: 5)
        setBorder(view: self.modifyPasswordBtn)
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
    }
    func initNavibar()
    {
        self.navigationItem.title = "设置"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
    }
    
    @IBAction func itemAction(_ sender: UIButton) {
        if sender.tag == 1 {
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
