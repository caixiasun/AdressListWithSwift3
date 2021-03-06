//
//  YTView.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 2016/9/16.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

//View
func YTDrawView(InView superView:UIView, Frame frame:CGRect) -> UIView
{
    let view = UIView(frame: frame)
    superView.addSubview(view)
    return view
}

func YTDrawView(InView superView:UIView, Frame frame:CGRect, BgColor bgColor:UIColor) -> UIView
{
    let view = YTDrawView(InView: superView, Frame: frame)
    view.backgroundColor = bgColor
    return view
}

//Label
func YTDrawLabel(InView superView:UIView, Frame frame:CGRect) -> UILabel
{
    let lab = UILabel(frame: frame)
    superView.addSubview(lab)
    return lab
}

func YTDrawLabel(InView superView:UIView, Frame frame:CGRect, BgColor bgColor:UIColor) -> UILabel
{
    let lab = YTDrawLabel(InView: superView, Frame: frame)
    lab.backgroundColor = bgColor
    return lab
}

func YTDrawLabel(InView superView:UIView, Frame frame:CGRect, BgColor bgColor:UIColor, Text text:String, TextColor textColor:UIColor) -> UILabel
{
    let lab = YTDrawLabel(InView: superView, Frame: frame, BgColor: bgColor)
    lab.text = text
    lab.textColor = textColor
    return lab
}

//Button
func YTDrawButton(frame:CGRect) -> UIButton
{
    let btn = UIButton(type: UIButtonType.custom)
    btn.frame = frame
    return btn
}
func YTDrawButton(InView superView:UIView, Frame frame:CGRect, Title title:String, TitleColor titleColor:UIColor) -> UIButton
{
    let btn = YTDrawButton(frame: frame)
    btn.setTitle(title, for: UIControlState.normal)
    btn.setTitleColor(titleColor, for: UIControlState.normal)
    superView.addSubview(btn)
    return btn
}

func YTDrawButton(InView superView:UIView, Frame frame:CGRect, Title title:String, TitleColor titleColor:UIColor, Target target:AnyObject, Action actionString:String) -> UIButton
{
    let btn = YTDrawButton(InView: superView, Frame: frame, Title: title, TitleColor: titleColor)
    btn.addTarget(target, action: Selector.init(actionString), for: UIControlEvents.touchUpInside)
    return btn
}

func YTDrawButton(InView superView:UIView, Frame frame:CGRect, Img imgName:String, Target target:AnyObject, Action actionString:String) -> UIButton
{
    let btn = YTDrawButton(frame: frame)
    btn.setImage(UIImage(named: imgName), for: UIControlState.normal)
    btn.addTarget(target, action: Selector.init(actionString), for: UIControlEvents.touchUpInside)
    return btn
}

/**
 根据title设置btn的size（一般用于导航上的按钮）
 */
func YTDrawButton(title:String, TitleColor titleColor:UIColor, FontSize fontSize:CGFloat, Target target:AnyObject, Action action:Selector) -> UIButton
{
    let size = calculateSizeWithContent(content: title, fontSize: fontSize, originW: kScreenWidth*0.4, originH: 30)
    let btn = UIButton(type: UIButtonType.custom)
    setYTSize(obj: btn, size: size)
    btn.setTitle(title, for: UIControlState.normal)
    btn.setTitleColor(titleColor, for: UIControlState.normal)
    btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    return btn
}

func YTDrawButton(frame:CGRect, Img img:UIImage!) -> UIButton
{
    let btn = YTDrawButton(frame: frame)
    btn.setBackgroundImage(img, for: UIControlState.normal)
    return btn
}

func YTDrawButton(frame:CGRect, Img img:UIImage!, Target target:AnyObject, Action action:Selector) -> UIButton
{
    let btn = YTDrawButton(frame: frame, Img: img)
    btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
    return btn
}

//ImageView
func YTDrawImgView(InView superView:UIView, Frame frame:CGRect, Img imgName:String) -> UIImageView
{
    let imgView = UIImageView(frame: frame)
    imgView.image = UIImage(named: imgName)
    superView.addSubview(imgView)
    return imgView
}

//图片压缩
func scaleImage(Image image:UIImage) -> UIImage
{
    let scaleBy:CGFloat = 0.6
    let size = CGSize(width: image.size.width, height: image.size.height)
    UIGraphicsBeginImageContext(size)
    let context = UIGraphicsGetCurrentContext()
    var transform = CGAffineTransform.identity
    
    transform = transform.scaledBy(x: scaleBy, y: scaleBy)
    context!.concatenate(transform);
    
    // Draw the image into the transformed context and return the image
    image.draw(at: CGPoint(x: 0, y: 0))
    
    let newimg = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newimg!
}
//图片裁剪  由中心开始，大小为（80，80）
func cropToBounds(image: UIImage) -> UIImage {
    
    let width:CGFloat = 80.0
    let height:CGFloat = 80.0
    let contextImage: UIImage = UIImage(cgImage: image.cgImage!)
    
    let contextSize: CGSize = contextImage.size
    
    var posX: CGFloat = 0.0
    var posY: CGFloat = 0.0
    var cgwidth: CGFloat = CGFloat(width)
    var cgheight: CGFloat = CGFloat(height)
    
    // See what size is longer and create the center off of that
    if contextSize.width > contextSize.height {
        posX = ((contextSize.width - contextSize.height) / 2)
        posY = 0
        cgwidth = contextSize.height
        cgheight = contextSize.height
    } else {
        posX = 0
        posY = ((contextSize.height - contextSize.width) / 2)
        cgwidth = contextSize.width
        cgheight = contextSize.width
    }
    
    let rect: CGRect = CGRect(x:posX, y:posY, width:cgwidth, height:cgheight)
    
    // Create bitmap image from context using the rect
    let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
    
    // Create a new image based on the imageRef and rotate back to the original orientation
    let image: UIImage = UIImage(cgImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
    
    return image
}

//cover view
func YTDrawCoverView(InView superView:UIView, Frame frame:CGRect, Target target:AnyObject, Action action:Selector) -> UIView
{
    let coverV = UIView()
    coverV.frame = frame
    coverV.backgroundColor = BlackColor
    coverV.alpha = 0.3
    coverV.isHidden = true
    let tap = UITapGestureRecognizer(target: target, action: action)
    coverV.addGestureRecognizer(tap)
    superView.addSubview(coverV)
    return coverV
}
