//
//  YTColor.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 2016/9/16.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

let WhiteColor = UIColor.white
let BlackColor = UIColor.black
let RedColor = UIColor.red
let GreenColor = UIColor.green
let BlueColor = UIColor.blue
let GrayColor = UIColor.gray
let OrangeColor = UIColor.orange
let PurpleColor = UIColor.purple
let ClearColor = UIColor.clear


func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor
{
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//十六进制颜色宏
func colorWithHexString(hex:String) -> UIColor
{
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString = (cString as NSString).substring(from: 1)
    }
    
    let rString = (cString as NSString).substring(to: 2)
    let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
    let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    
    
    
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}

let MainColor = colorWithHexString(hex: "35C6FF")
let DeepMainColor = colorWithHexString(hex: "2EB6EB")
let DeepGrayColor = colorWithHexString(hex: "7A7A7F")//搜索框的颜色
let PageGrayColor = colorWithHexString(hex: "F6F6F6")
let LineColor = colorWithHexString(hex: "C9C7CD")
let TextGrayColor = colorWithHexString(hex: "555555")

