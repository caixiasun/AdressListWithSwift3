//
//  DebugLogTool.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/23.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class DebugLogTool: NSObject {
    /*
     *  自定义log，debug状态下输出
     */
    static func debugLog(item:Any) {
        #if DEBUG
            print(item)
        #else
        
        #endif
    }
    static func debugRequestLog(item:Any) {
        #if DEBUG
            print("request:\(item)")
        #else
            
        #endif
    }
    static func debugRequestLog(item:Any,params:Any) {
        #if DEBUG
            print("request:\(item)\n params:\(params)")
        #else
            
        #endif
    }
    
}
