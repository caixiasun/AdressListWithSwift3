//
//  AllEnumDefine.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

//请假状态
enum LeaveStatus:Int {
    case NoPass = 1, //未通过
    AlreadyPass = 2, //已通过
    Refused = 3, //审核拒绝
    TerminateLeave = 4 //已销假
}
