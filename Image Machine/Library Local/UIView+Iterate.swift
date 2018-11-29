//
//  UIView+Iterate.swift
//  Choose My Story
//
//  Created by Martin Tjandra on 20/06/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    private func traverse (view: UIView, level: Int = 0, operation: ((UIView)->Void)) {
        for el in view.subviews {
            operation(el);
            traverse(view: el, level: level + 1, operation: operation);
        }
    }
    
    func traverse (operation: ((UIView)->Void)) {
        operation(self);
        traverse(view: self, operation: operation);
    }
    
    func traverse (operation: ((UIView)->Void), whenDone: (()->Void)) {
        traverse(operation: operation);
        whenDone();
    }
    
    func traverseTextField (operation: ((UITextField)->Void)) {
        traverse() { if let t = $0 as? UITextField { operation(t); } }
    }
    
    func traverseTextField (operation: ((UITextField)->Void), whenDone: (()->Void)) {
        traverseTextField (operation: operation, whenDone: whenDone);
    }
    
    func traverseTextView (operation: ((UITextView)->Void)) {
        traverse() { if let t = $0 as? UITextView { operation(t); } }
    }
    
    func traverseTextView (operation: ((UITextView)->Void), whenDone: (()->Void)) {
        traverseTextView (operation: operation, whenDone: whenDone);
    }
    
    func traverseButton (operation: ((UIButton)->Void)) {
        traverse() { if let t = $0 as? UIButton { operation(t); } }
    }
    
    func traverseButton (operation: ((UIButton)->Void), whenDone: (()->Void)) {
        traverseButton (operation: operation, whenDone: whenDone);
    }
    
    func traverseResponder (operation: ((UIView)->Void)) {
        traverse() { if ($0 as? UITextField) != nil || ($0 as? UITextView) != nil { operation($0); } }
    }
    
    func traverseResponder (operation: ((UIView)->Void), whenDone: (()->Void)) {
        traverseResponder (operation: operation, whenDone: whenDone);
    }
    
    func traverseLabel (operation: ((UILabel)->Void)) {
        traverse() { if let t = $0 as? UILabel { operation(t); } }
    }
    
    func traverseLabel (text: String? = nil, textAlignment: NSTextAlignment? = nil, textColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        traverseLabel {
            $0.text = text ?? $0.text;
            $0.textColor = textColor ?? $0.textColor;
            $0.backgroundColor = backgroundColor ?? $0.backgroundColor;
            $0.textAlignment = textAlignment ?? $0.textAlignment;
        }
    }
}
