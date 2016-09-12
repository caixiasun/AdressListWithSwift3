//
//  YTTabBarController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class YTTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
    }
    
    func initSubviews()
    {
        let tabBarTintColor = colorWithHexString(hex:"2CA6D7")
        self.tabBar.tintColor = tabBarTintColor
        self.tabBar.backgroundImage = UIImage(named: "white.png")
        let height = ETHeight(obj: self.tabBar)
        
        let blurtEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let effect = UIVisualEffectView(effect: blurtEffect)
        setETSize(obj: effect, size: CGSize(width:kScreenWidth, height:height))
        self.tabBar.addSubview(effect)
        
        let naviContact = YTNavigationController(rootViewController: ContactController())
        naviContact.initNavigationBar()
        let itemContact = UITabBarItem(title: "首页", image: UIImage(named: "home.png"), selectedImage: UIImage(named: "home.png"))
        naviContact.tabBarItem = itemContact
        
        let naviLeaveList = YTNavigationController(rootViewController: LeaveListController())
        naviLeaveList.initNavigationBar()
        let itemLeaveList = UITabBarItem(title: "请假列表", image: UIImage(named: "message.png"), selectedImage: UIImage(named: "message.png"))
        naviLeaveList.tabBarItem = itemLeaveList
        
        self.viewControllers = [naviContact,naviLeaveList]
    }
   func setTabBarHidden(status:Bool)
    {
        tabBar.isHidden = status
    }

}
