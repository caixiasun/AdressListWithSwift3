//
//  YTTabBarController.swift
//  AdressListWithSwift2
//
//  Created by yatou on 16/9/7.
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
        self.tabBar.backgroundImage = UIImage(named: "clear.png")
        let height = getYTHeight(obj: self.tabBar)
        
        let blurtEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let effect = UIVisualEffectView(effect: blurtEffect)
        setYTSize(obj: effect, size: CGSize(width:kScreenWidth, height:height))
        self.tabBar.addSubview(effect)
        
        let naviContact = YTNavigationController(rootViewController: ContactController())
        naviContact.index = 1
        naviContact.initNavigationBar()
        let itemContact = UITabBarItem(title: "首页", image: UIImage(named: "home.png"), selectedImage: UIImage(named: "home.png"))
        naviContact.tabBarItem = itemContact
        
        let naviLeaveList = YTNavigationController(rootViewController: LeaveListController())
        naviLeaveList.index = 2
        naviLeaveList.initNavigationBar()
        let itemLeaveList = UITabBarItem(title: "请假列表", image: UIImage(named: "leave.png"), selectedImage: UIImage(named: "leave.png"))
        naviLeaveList.tabBarItem = itemLeaveList
        
        let naviMy = YTNavigationController(rootViewController: MyController())
        naviMy.index = 3
        naviMy.initNavigationBar()
        let itemMy = UITabBarItem(title: "更多", image: UIImage(named: "more.png"), selectedImage: UIImage(named: "more.png"))
        naviMy.tabBarItem = itemMy
        
        self.viewControllers = [naviContact,naviLeaveList,naviMy]
    }
   func setTabBarHidden(status:Bool)
    {
        tabBar.isHidden = status
    }
}
