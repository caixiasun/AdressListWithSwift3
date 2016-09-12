//
//  ETView.swift
//  L05TableViewDemo
//
//  Created by Enjoytouch on 16/3/9.
//  Copyright © 2016年 CaixiaSun. All rights reserved.
//

import UIKit

let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = kScreenBounds.size.width
let kScreenHeight = kScreenBounds.size.height
let kNavigationBar_button_w:CGFloat = 20
let kFontSize_navigationBar_button:CGFloat = 15

func ETX(obj:UIView) -> CGFloat
{
    return obj.frame.origin.x
}
func setETX(obj:UIView,x:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.x = x
    obj.frame = frame
}

func ETY(obj:UIView) -> CGFloat
{
    return obj.frame.origin.y
}
func setETY(obj:UIView,y:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.y = y
    obj.frame = frame
}

func ETWidth(obj:UIView) -> CGFloat
{
    return obj.frame.size.width
}
func setETWidth(obj:UIView,width:CGFloat) -> () {
    var frame = obj.frame
    frame.size.width = width
    obj.frame = frame
}

func ETHeight(obj:UIView) -> CGFloat
{
    return obj.frame.size.height
}
func setETHeight(obj:UIView,height:CGFloat) -> () {
    var frame = obj.frame
    frame.size.height = height
    obj.frame = frame
}

func ETTop(obj:UIView) -> CGFloat
{
    return obj.frame.origin.y
}
func setETTop(obj:UIView,top:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.y = top
    obj.frame = frame
}

func ETBottom(obj:UIView) -> CGFloat
{
    return obj.frame.origin.y + obj.frame.size.height
}
func setETBottom(obj:UIView,bottom:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.y = bottom - frame.size.height
    obj.frame = frame
}

func ETLeft(obj:UIView) -> CGFloat
{
    return obj.frame.origin.x
}
func setETLeft(obj:UIView,left:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.x = left
    obj.frame = frame
}

func ETRight(obj:UIView) -> CGFloat
{
    return obj.frame.origin.x + obj.frame.size.width
}
func setETRight(obj:UIView,right:CGFloat) -> () {
    var frame = obj.frame
    frame.origin.x = right - frame.size.width
    obj.frame = frame
}

func ETCenterX(obj:UIView) -> CGFloat
{
    return obj.center.x
}
func setETCenterX(obj:UIView,x:CGFloat) -> () {
    var center = obj.center
    center.x = x
    obj.center = center
}

func ETCenterY(obj:UIView) -> CGFloat
{
    return obj.center.y
}
func setETCenterY(obj:UIView,y:CGFloat) -> () {
    var center = obj.center
    center.y = y
    obj.center = center
}

func ETSize(obj:UIView) -> CGSize {
    return obj.frame.size
}
func setETSize(obj:UIView,size:CGSize) -> () {
    var newSize = obj.frame.size
    newSize = size
    obj.frame.size = newSize
}

