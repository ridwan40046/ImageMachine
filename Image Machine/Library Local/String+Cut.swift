//
//  String+Cut.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 02/10/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func leftTrim (n: Int) -> String {
        if n > self.count { return ""; }
        return String(self.suffix(from: self.index(self.startIndex, offsetBy: n)));
    }
    
    func rightTrim (n: Int) -> String {
        if n > self.count { return ""; }
        return String(self.self.prefix(upTo: self.index(self.startIndex, offsetBy: n)));
    }
}
