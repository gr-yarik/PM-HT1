//
//  ViewController+Ext.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 09.12.2020.
//

import UIKit

extension UIViewController {
    
    func presentAlertOnMainThread(title: String = "Warning", message: String) {
        DispatchQueue.main.async {
            let infoAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let actionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            actionButton.setValue(UIColor.systemGreen, forKey: "titleTextColor")
            //        actionButton.tintColor = .systemGreen
            infoAlertController.addAction(actionButton)
            self.present(infoAlertController, animated: true, completion: nil)
        }
    }
    
}
