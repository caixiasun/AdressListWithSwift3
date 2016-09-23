//
//  UserModel.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class UserModel: NSObject {
    var delegate:UserModelDelegate?
    let manager = AFHTTPRequestOperationManager()
    
    /*****登录********/
    func requestLogin(Params params:Dictionary<String,Any>) {
        let url = "http://address.uduoo.com/login"
        DebugLogTool.debugRequestLog(item: url)
        let type="application/json"
        let sets=NSSet()
        manager.responseSerializer.acceptableContentTypes = sets.adding(type)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let user = UserData().mj_setKeyValues(dic["data"])
                self.delegate?.loginSucc!(userData: user!)
            }else{//请求失败  status=error
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.loginFail!(error: data)
            }
            
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.loginFail!(error: data)
        }
    }
}

@objc protocol UserModelDelegate {
    @objc optional func loginSucc(userData:UserData)
    @objc optional func loginFail(error:ErrorData)
}


