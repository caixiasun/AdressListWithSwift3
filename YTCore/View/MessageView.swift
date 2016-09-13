//
//  MessageView.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/13.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MessageView: UIView {
    
    var _titleLab:UILabel?
    let viewW:CGFloat = kScreenWidth-100
    

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: viewW, height: 50))
        
        self.backgroundColor = BlackColor
        self.alpha = 0.8
        self.isHidden = true
        setCornerRadius(view: self, radius: 15)
        setETTop(obj: self, top: kScreenHeight*0.3)
        setETCenterX(obj: self, x: kScreenWidth*0.5)
        
        _titleLab = UILabel()
        _titleLab?.numberOfLines = 0
        _titleLab?.textColor = WhiteColor
        _titleLab?.font = UIFont.systemFont(ofSize: 15)
        _titleLab?.textAlignment = .center
        self.addSubview(_titleLab!)
    }
    
    func setMessage(Message mess:String)
    {
        if mess.isEmpty
        {
            return ;
        }
        
        self.isHidden = false
        _titleLab?.text = mess
        let size = calculateSizeWithContent(content: mess, fontSize: 15, originW: viewW, originH: kScreenHeight)
        setETSize(obj: _titleLab!, size: size)
        setETSize(obj: self, size: CGSize(width: size.width+30, height: size.height+30))
        setETTop(obj: _titleLab!, top: 15)
        setETLeft(obj: _titleLab!, left: 15)
        setETTop(obj: self, top: kScreenHeight*0.3)
        setETCenterX(obj: self, x: kScreenWidth*0.5)
    }
    func setMessage(Message mess:String, Duration duration:TimeInterval)
    {
        self.setMessage(Message: mess)
        perform(#selector(hideMessage), with: nil, afterDelay: duration)
    }
    func hideMessage()
    {
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//在视图上添加MessageView
func addMessageView(InView superView:UIView) -> MessageView
{
    let messageView = MessageView(frame: .zero)
    superView.addSubview(messageView)
    return messageView
}
