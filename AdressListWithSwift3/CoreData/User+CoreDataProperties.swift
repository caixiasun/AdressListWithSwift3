//
//  User+CoreDataProperties.swift
//  
//
//  Created by caixiasun on 16/9/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var address: String?
    @NSManaged public var birthDay: String?
    @NSManaged public var department: String?
    @NSManaged public var email: String?
    @NSManaged public var headImg: NSData?
    @NSManaged public var id: String?
    @NSManaged public var isLeave: Bool
    @NSManaged public var name: String?
    @NSManaged public var nickName: String?
    @NSManaged public var level: String?
    @NSManaged public var tel: String?
    @NSManaged public var token: String?
    @NSManaged public var status: String?
    @NSManaged public var count: Int16
    @NSManaged public var sex: Bool
    @NSManaged public var departmentId: Int16

}
