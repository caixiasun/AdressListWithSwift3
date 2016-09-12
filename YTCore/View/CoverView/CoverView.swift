//
//  CoverView.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/9.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class CoverView: UIView {
    
    var coverView:UIView?
    override init(frame: CGRect) {        
        super.init(frame: frame)
        
        if coverView != nil {
            return ;
        }
        let view = UIView()
        view.frame = frame
        view.center = (appDelegate.window?.center)!
        view.backgroundColor = BlackColor
        view.alpha = 0.2
        view.isHidden = true
        coverView = view
        appDelegate.window?.addSubview(coverView!)
        
        //        let btn = ETDrawButton(view.bounds)
        //        btn.addTarget(self, action: #selector(CoverView.tapAction), forControlEvents: UIControlEvents.TouchUpInside)
        //        coverView?.addSubview(btn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCoverViewHidden(status:Bool)
    {
        coverView?.isHidden = status
    }
    func tapAction()
    {
        coverView?.isHidden = true
    }
   

}
