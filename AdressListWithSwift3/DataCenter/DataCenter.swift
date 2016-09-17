//
//  DataCenter.swift
//  AdressListWithSwift3
//
//  Created by 侯康柱 on 2016/9/17.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

let kFirstLaunch = "isFirstLaunch"
//let center = DataCenter()
class DataCenter: AnyObject {
//    var data:[String:Any] = Dictionary()
//    var data: Dictionary = Dictionary()
    //单例
    static let center:DataCenter = DataCenter()
     var dataCenter:NSMutableDictionary = NSMutableDictionary()
    class func shareInstance() ->DataCenter {
        return center
    }
    func isFirstLaunch() -> Bool
    {
        let userDefault = UserDefaults.standard
        var isFirst:Bool = true
        let value = userDefault.object(forKey: kFirstLaunch)
        if value != nil && value as! Int == 1 {
            isFirst = false
        }
        return isFirst
    }
    func setObject(Obj obj:AnyObject, ForKey key:String)
    {
        dataCenter.setObject(obj, forKey: key as NSCopying)
    }
}
let dataCenter = DataCenter.shareInstance()

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
        addCoreDataFromArray(ModelList: userList!)
    }catch let erro as Error!{
        print("读取本地数据出现错误！",erro)
    }
    return userList!
}
