//
//  YTButton.swift
//  AdressListWithSwift3
//
//  Created by JackAndney on 2016/10/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit
/*
 *  可以通过block回调，也可以通过delegate，看个人喜好
 */
let YTButton_Height:CGFloat = 40
typealias YTButtonCallBack = () -> Void//通过block回调

class YTButton: UIView {
    
    private var titleLab:UILabel!
    var delegate:YTButtonDelegate?//通过delegate回调
    var callBack:YTButtonCallBack?
    
    override init(frame: CGRect) {
        super.init(frame:.zero)
        
        self.backgroundColor = ClearColor
    
        self.layer.borderColor = MainColor.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPosition(top:CGFloat,left:CGFloat,right:CGFloat) {
        var frame:CGRect = .zero
        frame.origin.x = left
        frame.origin.y = top
        frame.size.width = kScreenWidth-right - left
        frame.size.height = YTButton_Height
        self.frame = frame
        
        self.setupUI()
    }
    
    func setupUI() {
        self.titleLab = UILabel(frame:self.bounds)
        self.titleLab.text = "Button"
        self.titleLab.textColor = MainColor
        self.titleLab.textAlignment = .center
        self.addSubview(self.titleLab)
    }
    func setTitle(title:String) {
        self.titleLab.text = title
    }
    
    //MARK:- action method
    func tapAction() {
        self.startAnimation()
    }
    func startAnimation() {
        let duration:TimeInterval = 0.2
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            }) { (stop) in
                UIView.animate(withDuration: duration, animations: {
                    self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    }, completion: { (stop) in
                        
                        UIView.animate(withDuration: duration, animations: {
                            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                            }, completion: { (stop) in
                                if (self.delegate != nil) {
                                    self.delegate?.ytbuttonAction!()
                                    return
                                }
                                if (self.callBack != nil) {
                                    self.callBack!()
                                    return
                                }
                        })
                })
        }
    }
    
}

@objc protocol YTButtonDelegate {
    @objc optional func ytbuttonAction()
}
