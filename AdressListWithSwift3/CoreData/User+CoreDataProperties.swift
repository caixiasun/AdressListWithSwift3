//
//  User+CoreDataProperties.swift
//  
//
//  Created by caixiasun on 16/9/12.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var headImg: String?
    @NSManaged public var isLeave: Bool
    @NSManaged public var name: String?
    @NSManaged public var telephone: String?

}
