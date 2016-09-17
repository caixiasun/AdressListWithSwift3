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

//返回新的

//添加一条数据entity
func getEntity(Model userModel:UserModel) ->User
{
    let entity = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: appDelegate.managedObjectContext) as! User
    entity.name = userModel.name
    entity.tel = userModel.tel
    if userModel.email != nil && !((userModel.email?.isEmpty)!) {
        entity.email = userModel.email
    }
    if userModel.address != nil && !((userModel.address?.isEmpty)!) {
        entity.address = userModel.address
    }
    if userModel.birthDay != nil && !((userModel.birthDay?.isEmpty)!) {
        entity.birthDay = userModel.birthDay
    }
    return entity
}
func addCoreData(Model userModel:UserModel)
{
    let _ = getEntity(Model: userModel)
    do
    {
        try appDelegate.managedObjectContext.save()
        print("添加成功 ~ ~ ")
    }catch
    {
        print("添加失败！！")
    }
}
//添加多条数据
//参数:modelList   数组:  对象类型:UserModel
func addCoreDataFromArray(ModelList modelList:NSArray)
{
    for item in modelList {
        let model = item as! UserModel
        addCoreData(Model: model)
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
    let entity:NSEntityDescription = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)!
    request.entity = entity
    do{
        let userList = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
        if userList.count != 0 {
            let user = userList[0] as! User
            user.headImg = UIImageJPEGRepresentation(userModel.headImg!, 1) as NSData?
            user.name = userModel.name
            user.tel = userModel.tel
            user.email = userModel.email
            user.birthDay = userModel.birthDay
            user.address = userModel.address
            try appDelegate.managedObjectContext.save()
            print("修改成功 ~ ~")
        }else{
            print("修改失败，没有符合条件的联系人！")
        }
    }catch{
        print("修改失败 ~ ~")
    }
    
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
    model.birthDay = "1990.02.03"
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
