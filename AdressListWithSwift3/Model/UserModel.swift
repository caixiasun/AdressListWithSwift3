//
//  UserModel.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class UserModel: NSObject {

    var name:String?
    var tel:String?
    var headImg:UIImage?
    var email:String?
    var address:String?
    var birthDay:String?
    var count:Int = 0
    var idNum:Int = 0 //id
    var isLeave:Bool = false //是否请假
    
    static func initWithUser(nUser user:User) -> UserModel
    {
        let model = UserModel()
        model.name = user.name
        model.tel = user.tel
        model.isLeave = user.isLeave
        if user.email != nil && !((user.email?.isEmpty)!) {
            model.email = user.email
        }
        if user.address != nil && !((user.address?.isEmpty)!) {
            model.address = user.address
        }
        if user.birthDay != nil && !((user.birthDay?.isEmpty)!) {
            model.birthDay = user.birthDay
        }
        if (user.headImg != nil) {
            model.headImg = UIImage(data: user.headImg! as Data)
        }
        return model
    }
}

///发送请求
func requestContact()
{
    let url = "http://meiyu-api.uduoo.com/a2/brand/index?city_id=2"
//    let ul="http://218.3.208.82:800/goldnurse/OFFER.GetOfferList.do"
    let params = ["lat": 39.26, "lon": 41.03, "cnt":0]
    let type="application/json"
    let sets=NSSet()
    let manager = AFHTTPRequestOperationManager()
    manager.responseSerializer.acceptableContentTypes = sets.adding(type)
    manager.get(url, parameters: params, success: { (oper, data) -> Void in
        let dic = data as! Dictionary<String, Any>
        let str = dic["data"]
        print(str)
    }) { (opeation, error) -> Void in
        print("error:",error)
        
    }
}
