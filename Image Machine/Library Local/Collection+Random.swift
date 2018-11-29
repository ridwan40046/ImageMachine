//
//  Collection+Random.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 22/10/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension Array {
    var randomItem : Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
