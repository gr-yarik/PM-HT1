//
//  PMTextView.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 10.12.2020.
//

import UIKit

class PMTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        textAlignment                               = .center
        layer.borderWidth                           = 1
        layer.cornerRadius                          = 10
        layer.borderColor                           = UIColor.systemGray4.cgColor
        translatesAutoresizingMaskIntoConstraints   = false
        font                                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontForContentSizeCategory           = true
        isEditable                                  = false
    }
}
