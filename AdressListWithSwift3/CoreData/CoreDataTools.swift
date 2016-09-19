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
func getEntity(Model data:UserData) ->User
{
    let entity = NSEntityDescription.insertNewObject(forEntityName: EntityName, into: appDelegate.managedObjectContext) as! User
    entity.name = data.name
    entity.tel = data.tel
    if data.email != nil && !((data.email?.isEmpty)!) {
        entity.email = data.email
    }
    if data.address != nil && !((data.address?.isEmpty)!) {
        entity.address = data.address
    }
    if data.birthDay != nil && !((data.birthDay?.isEmpty)!) {
        entity.birthDay = data.birthDay
    }
    if data.headImg != nil {
          //内存问题，等接口，暂时不存头像
        entity.headImg = UIImageJPEGRepresentation(data.headImg!, kCompression_index_headImg) as NSData?
    }
    return entity
}
func addCoreData(Model data:UserData)
{
    let _ = getEntity(Model: data)
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
//参数:modelList   数组:  对象类型:UserData
func addCoreDataFromArray(ModelList modelList:NSArray)
{
    for item in modelList {
        let data = item as! UserData
        addCoreData(Model: data)
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
func updateDataWithCoreData(Model userData:UserData, Where condiArray:NSArray)
{
    let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: EntityName)
    let entity:NSEntityDescription = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)!
    var name = condiArray[0] as! String
    name.insert("\'", at: name.startIndex)
    name.append("\'")
    let condition1 = "name=\(name)"
    let condition2 = "tel=\(condiArray[1])"
    let predicate = NSPredicate(format: condition1, condition2,"")
    request.entity = entity
    request.predicate = predicate
    do{
        let userList = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
        if userList.count != 0 {
            let user = userList[0] as! User
            //内存问题，等接口，暂时不存头像
            user.headImg = UIImageJPEGRepresentation(userData.headImg!, kCompression_index_headImg) as NSData?
            user.name = userData.name
            user.tel = userData.tel
            user.email = userData.email
            user.birthDay = userData.birthDay
            user.address = userData.address
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
func getDataFromCoreData() -> NSMutableArray
{
    var dataSource = NSArray()
    let resultList = NSMutableArray()
    let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
    let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)
    request.entity = entity
    do{
        dataSource = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
        for item in dataSource {
            let user = item as! User
            let data = UserData.initWithUser(nUser: user)
            resultList.add(data)
        }
        print("数据读取成功 ~ ~")
    }catch{
        print("get_coredata_fail!")
    }
    
    return resultList
}

//  -----------------------  测试部分  ----------------------------
///构建测试数据
func initTestDataWithModel() -> UserData
{
    let data = UserData()
    data.name = "丫头"
    data.tel = "15921815736"
    data.email = "123@456"
    data.birthDay = "1990.02.03"
    data.address = "中国上海普陀区"
    data.headImg = UIImage(named: "head.png")
    return data
}

//查询所有数据并输出
func printAllDataWithCoreData()
{
    let array = getDataFromCoreData()
    for item in array {
        let user = item as! UserData
        print("name=",user.name,"tel=",user.tel,"email=",user.email,"address=",user.address)
    }
}
