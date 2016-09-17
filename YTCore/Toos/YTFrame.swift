//
//  YTFrame.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 2016/9/16.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = kScreenBounds.size.width
let kScreenHeight = kScreenBounds.size.height
let kNavigationBar_button_w:CGFloat = 20
let kFontSize_navigationBar_button:CGFloat = 15

func getYTX(obj:UIView) -> CGFloat
{
    return obj.frame.origin.x
}
func setYTX(obj:UIView,x:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.x = x
    obj.frame = frame
}

func getYTY(obj:UIView) -> CGFloat
{
    return obj.frame.origin.y
}
func setYTY(obj:UIView,y:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.y = y
    obj.frame = frame
}

func getYTWidth(obj:UIView) -> CGFloat
{
    return obj.frame.size.width
}
func setYTWidth(obj:UIView,width:CGFloat) -> () {
    var frame = obj.frame
    frame.size.width = width
    obj.frame = frame
}

func getYTHeight(obj:UIView) -> CGFloat
{
    return obj.frame.size.height
}
func setYTHeight(obj:UIView,height:CGFloat) -> () {
    var frame = obj.frame
    frame.size.height = height
    obj.frame = frame
}

func getYTTop(obj:UIView) -> CGFloat
{
    return obj.frame.origin.y
}
func setYTTop(obj:UIView,top:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.y = top
    obj.frame = frame
}

func getYTBottom(obj:UIView) -> CGFloat
{
    return obj.frame.origin.y + obj.frame.size.height
}
func setYTBottom(obj:UIView,bottom:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.y = bottom - frame.size.height
    obj.frame = frame
}

func getYTLeft(obj:UIView) -> CGFloat
{
    return obj.frame.origin.x
}
func setYTLeft(obj:UIView,left:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.x = left
    obj.frame = frame
}

func getYTRight(obj:UIView) -> CGFloat
{
    return obj.frame.origin.x + obj.frame.size.width
}
func setYTRight(obj:UIView,right:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.x = right - frame.size.width
    obj.frame = frame
}

func getYTCenterX(obj:UIView) -> CGFloat
{
    return obj.center.x
}
func setYTCenterX(obj:UIView,x:CGFloat) -> () {
    var center = obj.center
    center.x = x
    obj.center = center
}

func getYTCenterY(obj:UIView) -> CGFloat
{
    return obj.center.y
}
func setYTCenterY(obj:UIView,y:CGFloat) -> () {
    var center = obj.center
    center.y = y
    obj.center = center
}

func getYTSize(obj:UIView) -> CGSize {
    return obj.frame.size
}
func setYTSize(obj:UIView,size:CGSize) -> () {
    var newSize = obj.frame.size
    newSize = size
    obj.frame.size = newSize
}


