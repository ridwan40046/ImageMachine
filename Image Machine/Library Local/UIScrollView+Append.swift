//
//  UIScrollView+Append.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 05/10/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    
    func appendPagedSubView (right view: UIView?) {
        guard let view = view else { return; }
        view.frame = self.bounds;
        var maxRight : CGFloat = 0;
        self.subviews.forEach { maxRight = max (maxRight, $0.right); }
        view.x = maxRight;
        self.contentWidth = view.right;
        self.contentHeight = max(self.contentHeight, view.bottom);
        self.addSubview(view);
    }
    
    func appendPagedSubView (bottom view: UIView?) {
        guard let view = view else { return; }
        view.frame = self.bounds;
        var maxBottom : CGFloat = 0;
        self.subviews.forEach { maxBottom = max (maxBottom, $0.bottom); }
        view.x = maxBottom;
        self.contentWidth = max(self.contentWidth, view.right);
        self.contentHeight = view.bottom;
    }
}
