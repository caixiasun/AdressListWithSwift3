//
//  YTOtherLibTool.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

///该类用于操作第三方库

class YTOtherLibTool: NSObject {
    
    var delegate:YTOtherLibToolDelegate?
    
    //下拉加载
     func addDownPullAnimate(InView view:UIScrollView)
    {
        let loadingViewCircle = JElasticPullToRefreshLoadingViewCircle()
        loadingViewCircle.tintColor = MainColor
        weak var weakSelf = self
        view.addJElasticPullToRefreshView(actionHandler: {
            //发送请求
            weakSelf?.delegate?.downpullRequest()
            }, loadingView: loadingViewCircle)
        view.setJElasticPullToRefreshFill(PageGrayColor)
        view.setJElasticPullToRefreshBackgroundColor(WhiteColor)
    }
}

@objc protocol YTOtherLibToolDelegate {
    func downpullRequest()
}
