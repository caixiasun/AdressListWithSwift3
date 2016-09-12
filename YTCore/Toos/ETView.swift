//
//  ETView.swift
//  L05TableViewDemo
//
//  Created by Enjoytouch on 16/3/9.
//  Copyright © 2016年 CaixiaSun. All rights reserved.
//

import UIKit

//View
func ETDrawView(InView superView:UIView, Frame frame:CGRect) -> UIView
{
    let view = UIView(frame: frame)
    superView.addSubview(view)
    return view
}

func ETDrawView(InView superView:UIView, Frame frame:CGRect, BgColor bgColor:UIColor) -> UIView
{
    let view = ETDrawView(InView: superView, Frame: frame)
    view.backgroundColor = bgColor
    return view
}

//Label
func ETDrawLabel(InView superView:UIView, Frame frame:CGRect) -> UILabel
{
    let lab = UILabel(frame: frame)
    superView.addSubview(lab)
    return lab
}

func ETDrawLabel(InView superView:UIView, Frame frame:CGRect, BgColor bgColor:UIColor) -> UILabel
{
    let lab = ETDrawLabel(InView: superView, Frame: frame)
    lab.backgroundColor = bgColor
    return lab
}

func ETDrawLabel(InView superView:UIView, Frame frame:CGRect, BgColor bgColor:UIColor, Text text:String, TextColor textColor:UIColor) -> UILabel
{
    let lab = ETDrawLabel(InView: superView, Frame: frame, BgColor: bgColor)
    lab.text = text
    lab.textColor = textColor
    return lab
}

//Button
func ETDrawButton(frame:CGRect) -> UIButton
{
    let btn = UIButton(type: UIButtonType.custom)
    btn.frame = frame
    return btn
}
func ETDrawButton(InView superView:UIView, Frame frame:CGRect, Title title:String, TitleColor titleColor:UIColor) -> UIButton
{
    let btn = ETDrawButton(frame: frame)
    btn.setTitle(title, for: UIControlState.normal)
    btn.setTitleColor(titleColor, for: UIControlState.normal)
    superView.addSubview(btn)
    return btn
}

func ETDrawButton(InView superView:UIView, Frame frame:CGRect, Title title:String, TitleColor titleColor:UIColor, Target target:AnyObject, Action actionString:String) -> UIButton
{
    let btn = ETDrawButton(InView: superView, Frame: frame, Title: title, TitleColor: titleColor)
    btn.addTarget(target, action: Selector.init(actionString), for: UIControlEvents.touchUpInside)
    return btn
}

func ETDrawButton(InView superView:UIView, Frame frame:CGRect, Img imgName:String, Target target:AnyObject, Action actionString:String) -> UIButton
{
    let btn = ETDrawButton(frame: frame)
    btn.setImage(UIImage(named: imgName), for: UIControlState.normal)
    btn.addTarget(target, action: Selector.init(actionString), for: UIControlEvents.touchUpInside)
    return btn
}

/**
 根据title设置btn的size（一般用于导航上的按钮）
 */
func ETDrawButton(title:String, TitleColor titleColor:UIColor, FontSize fontSize:CGFloat, Target target:AnyObject, Action action:Selector) -> UIButton
{
    let size = calculateSizeWithContent(content: title, fontSize: fontSize, originW: kScreenWidth*0.4, originH: 30)
    let btn = UIButton(type: UIButtonType.custom)
    setETSize(obj: btn, size: size)
    btn.setTitle(title, for: UIControlState.normal)
    btn.setTitleColor(titleColor, for: UIControlState.normal)
    btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    return btn    
}

func ETDrawButton(frame:CGRect, Img img:UIImage!) -> UIButton
{
    let btn = ETDrawButton(frame: frame)
    btn.setBackgroundImage(img, for: UIControlState.normal)
    return btn
}

func ETDrawButton(frame:CGRect, Img img:UIImage!, Target target:AnyObject, Action action:Selector) -> UIButton
{
    let btn = ETDrawButton(frame: frame, Img: img)
    btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    return btn
}

//ImageView
func ETDrawImgView(InView superView:UIView, Frame frame:CGRect, Img imgName:String) -> UIImageView
{
    let imgView = UIImageView(frame: frame)
    imgView.image = UIImage(named: imgName)
    superView.addSubview(imgView)
    return imgView
}


