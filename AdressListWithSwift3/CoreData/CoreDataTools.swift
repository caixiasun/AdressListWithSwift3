//
//  CoreDataTools.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/13.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class CoreDataTools: NSObject {

}


///CoreData操作
let EntityName = "User"

//添加数据
func addCoreData(Model userModel:UserModel)
{
    let entity = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: appDelegate.managedObjectContext) as! User
    entity.name = userModel.name
    entity.tel = userModel.tel
    if !((userModel.email?.isEmpty)!) {
        entity.email = userModel.email
    }
    if !((userModel.address?.isEmpty)!) {
        entity.address = userModel.address
    }
    if !((userModel.birthday?.isEmpty)!) {
        entity.birthDay = userModel.birthday
    }
    do
    {
        try appDelegate.managedObjectContext.save()
        print("添加成功 ~ ~ ")
    }catch
    {
        print("添加失败！！")
    }
}
//删除数据
//参数：conditionDic 条件字典，
func deleteCoreData(ConditionDic conditionDic:NSMutableDictionary)
{
    let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
    //构建条件
    var condition = String()
    var i = 0  //多个条件时中间用逗号隔开
    for item in conditionDic {
        var key = (item.key as? String)!
        if i > 0 {
            key.insert(",", at: key.startIndex)
        }
        let value = (item.value as? String)!
        key.append("=\'\(value)\'")
        condition.append(key)
        i = i+1
    }
    let predicate = NSPredicate(format: condition, "")
    request.predicate = predicate
    do{
        //查询满足条件的联系人
        let resultsList = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
        if resultsList.count != 0 {
            appDelegate.managedObjectContext.delete(resultsList[0] as! NSManagedObject)
            try appDelegate.managedObjectContext.save()
            print("delete success ~ ~")
        }else{
            print("删除失败！ 没有符合条件的联系人！")
        }
    }catch{
        print("delete fail !")
    }
}
//修改数据  
//参数：新数据model      where：条件  规定始终使用 tel 作为判断条件。
func updateDataWithCoreData(Model userModel:UserModel, Where condition:String)
{
    let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
    
}
//读取数据
func getDataFromCoreData() -> NSArray
{
    var dataSource = NSArray()
    let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
    let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)
    request.entity = entity
    do{
        dataSource = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
        print("数据读取成功 ~ ~")
    }catch{
        print("get_coredata_fail!")
    }
    
    return dataSource
}


//  -----------------------  测试部分  ----------------------------
///构建测试数据
func initTestDataWithModel() -> UserModel
{
    let model = UserModel()
    model.name = "丫头"
    model.tel = "15921815736"
    model.email = "123@456"
    model.birthday = "1990.02.03"
    model.address = "中国上海普陀区"
    model.headImg = UIImage(named: "head.png")
    return model
}

//查询所有数据并输出
func printAllDataWithCoreData()
{
    let array = getDataFromCoreData()
    for item in array {
        let user = item as! User
        print("name=",user.name,"tel=",user.tel,"email=",user.email,"address=",user.address)
    }
}
