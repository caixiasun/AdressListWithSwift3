//
//  SettingController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class SettingController: UIViewController {

    
    @IBOutlet weak var loginoutBtn: UIButton!
    var messageView:MessageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavibar()
        
        self.view.backgroundColor = PageGrayColor
        setCornerRadius(view: self.loginoutBtn, radius: 5)
        setBorder(view: self.loginoutBtn)
        self.messageView = addMessageView(InView: self.view)
    }
    func initNavibar()
    {
        self.navigationItem.title = "设置"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
    }
    
    @IBAction func itemAction(_ sender: UIButton) {
        //tag=1：退出登录
        self.messageView?.setMessage(Message: "退出登录成功！", Duration: 1)
        dataCenter.setLoginout()
        perform(#selector(changeTabBarController), with: nil, afterDelay: 1.5)
    }
    func changeTabBarController()
    {
        dismiss(animated: true, completion: nil)
        
        appDelegate.setTabBarSelectViewController(index: 0)
        appDelegate.loadLoginVC()
    }

}
