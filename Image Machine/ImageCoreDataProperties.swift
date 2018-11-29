//
//  Image+CoreDataProperties.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image")
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toItem: Machine?

}
