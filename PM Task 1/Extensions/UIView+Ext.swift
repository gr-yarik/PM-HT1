//
//  UIView+Ext.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 08.12.2020.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
