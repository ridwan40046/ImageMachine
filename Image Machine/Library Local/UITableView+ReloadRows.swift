//
//  UITableView+ReloadRows.swift
//  Digischool Dev
//
//  Created by Martin Tjandra on 23/10/18.
//  Copyright © 2018 idesolusiasia. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func reload (section: Int? = nil, row: Int?, with animation: UITableViewRowAnimation? = nil) {
        let section = section ?? 0;
        let animation = animation ?? .none;
        guard let row = row else { return; }
        let indexPath = IndexPath(item: row, section: section);
        self.reloadRows(at: [indexPath], with: animation);
    }
    
    func reloadVisibleRows (with animation: UITableViewRowAnimation? = .none) {
        let animation = animation ?? .none;
        guard let indexPathsForVisibleRows = indexPathsForVisibleRows else { return; }
        self.beginUpdates();
        self.reloadRows(at: indexPathsForVisibleRows, with: animation);
        self.endUpdates();
    }
    
}
