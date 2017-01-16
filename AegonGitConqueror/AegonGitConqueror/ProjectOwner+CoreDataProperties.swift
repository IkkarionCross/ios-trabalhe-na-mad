//
//  ProjectOwner+CoreDataProperties.swift
//  AegonGitConqueror
//
//  Created by victor-mac on 15/01/17.
//  Copyright © 2017 victor. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ProjectOwner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectOwner> {
        return NSFetchRequest<ProjectOwner>(entityName: "ProjectOwner");
    }

    @NSManaged public var id: Int16
    @NSManaged public var login: String?
    @NSManaged public var picture_url: String?
    @NSManaged public var oneormoreprojects: NSSet?

}

// MARK: Generated accessors for oneormoreprojects
extension ProjectOwner {

    @objc(addOneormoreprojectsObject:)
    @NSManaged public func addToOneormoreprojects(_ value: GitProject)

    @objc(removeOneormoreprojectsObject:)
    @NSManaged public func removeFromOneormoreprojects(_ value: GitProject)

    @objc(addOneormoreprojects:)
    @NSManaged public func addToOneormoreprojects(_ values: NSSet)

    @objc(removeOneormoreprojects:)
    @NSManaged public func removeFromOneormoreprojects(_ values: NSSet)

}
