//
//  PMTextField.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 08.12.2020.
//

import UIKit

enum AnimationType {
    case fadeIn
    case fadeOut
}

class PMTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, placeholder: String){
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.placeholder = placeholder
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 1
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .right
        font                        = UIFont.preferredFont(forTextStyle: .title2)

        adjustsFontForContentSizeCategory   = true
        adjustsFontSizeToFitWidth           = true
        
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .go
        keyboardType                = .numberPad
    }
}
