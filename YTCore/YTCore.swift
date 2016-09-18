//
//  YTCore.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/18.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class YTCore: NSObject {

}
//系统版本号
let kSystemVersionNum = (UIDevice.current.systemVersion as NSString).doubleValue
let kSystemVersionNum_Greater_Than_Or_Equal_To_10 = kSystemVersionNum >= 10.0 //系统版本号是否大于8.0
