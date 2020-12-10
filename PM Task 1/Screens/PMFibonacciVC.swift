//
//  PMFibonacciVC.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 06.12.2020.
//

import UIKit

class PMFibonacciVC: UIViewController {

    let numberTextField = PMTextField(textAlignment: .center, placeholder: "Specify a number")
    let outputTextView  = PMTextView()

    var bottomCoordinate: CGFloat {
        let value = outputTextView.contentSize.height - keyboardHeight
        if value < 0 {
            return 0
        } else {
            return value
        }
    }
    
    var delegate: UITextFieldDelegate!
    var keyboardHeight: CGFloat = 0
    
    let padding: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(numberTextField, outputTextView)
        configureViewController()
        configureNumberTextField()
        addKeyboardObservers()
        createDismissKeyboardTapGesture()
        layoutUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberTextField.becomeFirstResponder()
    }
    
    
    private func configureViewController() {
        view.backgroundColor    = .systemBackground
    }
    
    
    func configureNumberTextField() {
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    @objc private func textFieldDidChange() {
        outputTextView.text.removeAll()
        
        guard let text = numberTextField.text, let value = Int(text) else {
            clearTextFieldAndView()
            return
        }
        
        Fibonacci.calculate(till: value){ result in
            switch result {
            case .success(let array):
                for item in array {
                    outputTextView.text.append("\(item),\n")
                }
                outputTextView.text.removeLast(2)
                outputTextView.text.append(".")
            case .failure(let error):
                clearTextFieldAndView()
                presentAlertOnMainThread(message: error.rawValue)
            }
        }
        outputTextView.setContentOffset(CGPoint(x: 0, y: bottomCoordinate), animated: true)
    }
    
    
    private func clearTextFieldAndView(){
        numberTextField.text?.removeAll()
        outputTextView.text.removeAll()
    }
    
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillAppear(_ notification: NSNotification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let value = notification.userInfo?[key] as? NSValue else { return }
        
        keyboardHeight                          = value.cgRectValue.height
        outputTextView.contentInset             = .init(top: 0, left: 0, bottom: keyboardHeight - (tabBarHeight + padding), right: 0)
        outputTextView.scrollIndicatorInsets    = outputTextView.contentInset
       
    }
    
    
    @objc private func keyboardWillDisappear() {
        outputTextView.contentInset = .zero
        outputTextView.scrollIndicatorInsets = .zero
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func layoutUI() {
        
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            numberTextField.topAnchor.constraint(equalTo: margins.topAnchor, constant: padding),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            outputTextView.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: padding),
            outputTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            outputTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            outputTextView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -padding)
        ])
    }
}


extension PMFibonacciVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        clearTextFieldAndView()
    }
    
}
