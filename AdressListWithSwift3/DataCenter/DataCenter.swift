//
//  DataCenter.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 2016/9/16.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

//获取本地json数据
func getContactFromLocal() -> NSMutableArray
{
    var userList:NSMutableArray?
    let path = Bundle.main.path(forResource: "data", ofType: "json")
    let url = URL(fileURLWithPath: path!)
    do{
        let data = try Data(contentsOf: url)
        let json:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        let jsonDic = json as! Dictionary<String,Any>
        let datalist = jsonDic["data"] as! NSArray
        userList = UserModel.mj_objectArray(withKeyValuesArray: datalist)
    }catch let erro as Error!{
        print("读取本地数据出现错误！",erro)
    }
    return userList!
}
