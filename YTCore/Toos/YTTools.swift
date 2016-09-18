//
//  YTTools.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 2016/9/16.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

func println(str:String)
{
    print(str)
    print("\n")
}

func calculateSizeWithContent(content:String,fontSize:CGFloat, originW:CGFloat,originH:CGFloat) -> CGSize
{
    let size:CGSize
    size = (content.boundingRect(with: CGSize(width:originW, height:originH), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: fontSize)] , context: nil)).size;
    return CGSize(width:size.width+10, height:size.height+5)
}

/**
 *  设置控件的layer.cornerRadius
 */
func setCornerRadius(view:UIView, radius:CGFloat)
{
    view.layer.cornerRadius = radius
    view.layer.masksToBounds = true
}

func setBorder(view:UIView)
{
    view.layer.borderColor = GrayColor.cgColor
    view.layer.borderWidth = 0.2
}
