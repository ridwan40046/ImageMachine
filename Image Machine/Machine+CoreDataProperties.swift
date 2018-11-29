//
//  Machine+CoreDataProperties.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//
//

import Foundation
import CoreData


extension Machine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Machine> {
        return NSFetchRequest<Machine>(entityName: "Machine")
    }

    @NSManaged public var id: String?
    @NSManaged public var lastSeen: NSDate?
    @NSManaged public var name_machine: String?
    @NSManaged public var qrCode_machine: Int32
    @NSManaged public var type_machine: String?
    @NSManaged public var toImage: Image?

}
