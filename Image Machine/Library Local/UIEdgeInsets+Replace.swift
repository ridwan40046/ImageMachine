//
//  UIEdgeInsets+Replace.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 24/09/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    
    func replacing (top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> UIEdgeInsets {
        var res = self;
        res.top = top ?? res.top;
        res.left = left ?? res.left;
        res.bottom = bottom ?? res.bottom;
        res.right = right ?? res.right;
        return res;
    }
    
}
