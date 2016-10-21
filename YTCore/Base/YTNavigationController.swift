//
//  YTNavigationController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/8.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class YTNavigationController: UINavigationController {
    
    var index:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.navigationBar.isTranslucent = true
    }

    func setNavigationBarBackImg(img:UIImage!) -> ()
    {
        self.navigationBar.setBackgroundImage(img, for: UIBarMetrics.default)
    }
    
    func setNavigationBarFont(fontColor:UIColor) -> ()
    {
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:fontColor]
    }
    
    func setNavigationBarFont(fontSize:CGFloat,fontColor:UIColor) -> ()
    {
        self.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize),NSForegroundColorAttributeName:fontColor]
    }
    
    func initNavigationBar() -> ()
    {
        setNavigationBarBackImg(img: UIImage(named: "navi_bg-1.png"))
        setNavigationBarFont(fontColor: WhiteColor)
    }
    
    func initNavigationBar(bgImg:UIImage!, fontColor:UIColor) -> ()
    {
        setNavigationBarBackImg(img: bgImg)
        setNavigationBarFont(fontColor: fontColor)
    }

}
