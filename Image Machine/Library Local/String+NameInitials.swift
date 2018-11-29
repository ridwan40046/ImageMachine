//
//  String+NameInitials.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 24/09/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    var nameInitials : String {
        let arr = self.components(separatedBy: " ").filter { $0 != "" }
        var res = "";
        if let c = arr[safe: 0]?.first { res += String(c); }
        if let c = arr[safe: 1]?.first { res += String(c); }
        return res.uppercased();
    }
    
}
