//
//  UIScrollView+ContentOffset.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 05/10/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    var contentOffsetX : CGFloat {
        get { return contentOffset.x; }
        set { setContentOffset(CGPoint.init(x: newValue, y: contentOffset.y), animated: true); }
    }
    
    var contentOffsetY : CGFloat {
        get { return contentOffset.y; }
        set { setContentOffset(CGPoint.init(x: contentOffset.x, y: newValue), animated: true); }
    }
}
