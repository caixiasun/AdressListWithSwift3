//
//  MyController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyController: UIViewController {
    
    var messageView:MessageView?

    @IBOutlet weak var loginoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        
        if dataCenter.isAlreadyLogin() {
            let data = dataCenter.getUserData()
        }
        
    }
    func initSubviews()
    {
        self.messageView = addMessageView(InView: self.view)
        
        setBorder(view: self.loginoutBtn)
        setCornerRadius(view: self.loginoutBtn, radius: 10)
    }

    @IBAction func itemAction(_ sender: UIButton) {
        //tag=1 退出登录
        self.messageView?.setMessage(Message: "退出登录成功！", Duration: 1)
        dataCenter.setLoginout()
        //切换到首页
        tabBarController?.selectedIndex = 0
    }
   

}
