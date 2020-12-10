//
//  PMControlButton.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 06.12.2020.
//

import UIKit


enum ButtonAction {
    case decrement
    case increment
}

class PMControlButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(buttonAction: ButtonAction){
        self.init(frame: .zero)
        switch buttonAction {
        case .decrement:
            setTitle("-", for: .normal)
        case .increment:
            setTitle("+", for: .normal)
        }
        backgroundColor = .systemGreen
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius  = 10
        titleLabel?.font    = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0.8
    }
}
