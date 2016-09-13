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
        print("add success!")
    }catch
    {
        print("add fail!")
    }
}
//删除数据
//参数：conditionDic 条件字典，
func deleteCoreData(ConditionDic conditionDic:NSMutableDictionary)
{
    let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
    //构建条件
    var condition:String? = ""
    for item in conditionDic {
        print(item)
        let key = (item.key as? String)!
        let value = (item.value as? String)!
        let str = key + "=\'" + value + "'"
        condition = condition! + str
        
    }
    print("condition = ",condition)
    let predicate = NSPredicate(format: condition!, "")
    request.predicate = predicate
    do{
        //查询满足条件的联系人
        let resultsList = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
        if resultsList.count != 0 {
            appDelegate.managedObjectContext.delete(resultsList[0] as! NSManagedObject)
            try appDelegate.managedObjectContext.save()
            print("delete success ~ ~")
        }
    }catch{
        print("delete fail !")
    }
}
//修改数据
//读取数据
func getDataFromCoreData() -> NSArray
{
    var dataSource = NSArray()
    let request : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
    let entity:NSEntityDescription? = NSEntityDescription.entity(forEntityName: EntityName, in: appDelegate.managedObjectContext)
    request.entity = entity
    do{
        dataSource = try appDelegate.managedObjectContext.fetch(request) as! [User] as NSArray
    }catch{
        print("get_coredata_fail!")
    }
    
    return dataSource
}
