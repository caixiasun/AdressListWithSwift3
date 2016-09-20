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
    @IBOutlet weak var line_height1: NSLayoutConstraint!
    @IBOutlet weak var line_height2: NSLayoutConstraint!
    @IBOutlet weak var line_height3: NSLayoutConstraint!
    
    @IBOutlet weak var telLab: UILabel!
    @IBOutlet weak var nameLab: UILabel!
    
    @IBOutlet weak var partmentLab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func initSubviews()
    {
        self.messageView = addMessageView(InView: self.view)
        
        self.navigationItem.title = "账户信息"
        
        setBorder(view: self.loginoutBtn)
        setCornerRadius(view: self.loginoutBtn, radius: 10)
        
        self.line_height1.constant = 0.5
        self.line_height2.constant = 0.5
        self.line_height3.constant = 0.5
        
        if dataCenter.isAlreadyLogin() {
            let data = dataCenter.getUserData()
            self.nameLab.text = data.name
            self.telLab.text = data.tel
            self.partmentLab.text = data.department
        }
    }

    @IBAction func itemAction(_ sender: UIButton) {
        //tag=1 退出登录
        self.messageView?.setMessage(Message: "退出登录成功！", Duration: 1)
        dataCenter.setLoginout()
        perform(#selector(changeTabBarController), with: nil, afterDelay: 1.5)
    }
    func changeTabBarController()
    {
        appDelegate.setTabBarSelectViewController(index: 0)
        appDelegate.loadLoginVC()
    }
}
