//
//  Machine+CoreDataClass.swift
//  Image Machine
//
//  Created by Ridwan Surya Putra on 11/28/18.
//  Copyright © 2018 Ridwan Surya Putra. All rights reserved.
//
//

import Foundation
import CoreData

//@objc(Machine)

public class Machine: NSManagedObject {
    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.lastSeen = NSDate()
    }
}
