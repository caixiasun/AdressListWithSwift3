//
//  SuccessData.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class SuccessData: NSObject {
    var success:String?
    var message:String?
    
    class func initWithError(obj:Any?) -> SuccessData{
        let succObj = obj as? Dictionary<String,Any>
        let succData = SuccessData()
        if succObj == nil {
            succData.message = "未知错误！"
            return succData
        }
        
        succData.message = succObj?["message"] as! String?
        succData.success = succObj?["success"] as! String?
        return succData
    }
}
