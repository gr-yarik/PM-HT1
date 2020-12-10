//
//  PMTitleLabel.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 09.12.2020.
//

import UIKit

class PMTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(text: String, textAlignment: NSTextAlignment){
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(){
        font = UIFont.preferredFont(forTextStyle: .title2)
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory   = true
        adjustsFontSizeToFitWidth           = true
        minimumScaleFactor    = 0.75
        textAlignment = .left
        lineBreakMode = .byTruncatingTail
    }
}
