//
//  UITableView+ContentInset.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 24/09/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    var contentInsetTop : CGFloat {
        get { return self.contentInset.top; }
        set { self.contentInset = self.contentInset.replacing(top: newValue); }
    }
    
    var contentInsetLeft : CGFloat {
        get { return self.contentInset.left; }
        set { self.contentInset = self.contentInset.replacing(left: newValue); }
    }

    var contentInsetBottom : CGFloat {
        get { return self.contentInset.bottom; }
        set { self.contentInset = self.contentInset.replacing(bottom: newValue); }
    }

    var contentInsetRight : CGFloat {
        get { return self.contentInset.right; }
        set { self.contentInset = self.contentInset.replacing(right: newValue); }
    }
    
}
