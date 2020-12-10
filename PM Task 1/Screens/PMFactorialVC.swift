//
//  ViewController.swift
//  PM Task 1
//
//  Created by Yaroslav Hrytsun on 06.12.2020.
//

import UIKit

class PMFactorialVC: UIViewController {

    let decrementButton     = PMControlButton(buttonAction: .decrement)
    let incrementButton     = PMControlButton(buttonAction: .increment)
    let numberTextField     = PMTextField()
    let signLabel           = PMTitleLabel(text: "! =", textAlignment: .center)
    let calculatedLabel     = PMTitleLabel()
    let usedAlgrorithmLabel = PMTitleLabel(textAlignment: .center)
    
    var isEditingNumber = true {
        didSet {
            animateNumberTFBorder(animationType: isEditingNumber ? .fadeOut : .fadeIn)
        }
    }
    var calculationResult: BInt? {
        didSet {
            guard let calculationResult = calculationResult else {
                calculatedLabel.text = ""
                return
            }
            calculatedLabel.text = " \(calculationResult)"
        }
    }
    
    var delegate: UITextFieldDelegate!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(signLabel, calculatedLabel, numberTextField, decrementButton, incrementButton, usedAlgrorithmLabel)
        configureViewController()
        configureNumberTextField()
        configureActionButtons()
        createDismissKeyboardTapGesture()
        addKeyboardObservers()
        layoutUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberTextField.becomeFirstResponder()
        animateNumberTFBorder(animationType: .fadeOut)
    }
    
    
    private func configureViewController() {
        let infoBarButtonItem                           = UIBarButtonItem(image: Images.info, style: .plain, target: self, action: #selector(infoTapped))
        navigationItem.rightBarButtonItem               = infoBarButtonItem
        
        navigationItem.rightBarButtonItem?.tintColor    = .systemGreen
        view.backgroundColor                            = .systemBackground
    }
    
    
    @objc private func infoTapped(){
        presentAlertOnMainThread(title: "Take note", message: PMMessage.info.rawValue)
    }
    

    private func configureNumberTextField() {
        numberTextField.delegate = self
        numberTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    
    @objc private func textFieldDidChange() {
        guard let text = numberTextField.text, let value = Int(text) else {
            clearTextFieldsAndLabels()
            return
        }
        
        if value == 0 {
            calculatedLabel.text        = "1"
            usedAlgrorithmLabel.text    = "Edge case"
            return
        }
        
        let randomAlgorithmType = AlgorithmType.allCases.randomElement() ?? .iterative
        Factorial.calculate(factorialOf: value, algorithmType: randomAlgorithmType) { result in
            switch result {
            case .success(let resultValue):
                calculationResult = resultValue
                usedAlgrorithmLabel.text = "Algorithm used: \(randomAlgorithmType.rawValue)"
            case .failure(let error):
                clearTextFieldsAndLabels()
                presentAlertOnMainThread(message: error.rawValue)
                incrementButton.sendActions(for: .touchUpInside)
            }
        }
    }
    
    
    private func configureActionButtons() {
        decrementButton.addTarget(self, action: #selector(decrementButtonDown), for: .touchDown)
        decrementButton.addTarget(self, action: #selector(ActionButtonUp), for: [.touchUpInside, .touchUpOutside])
        
        incrementButton.addTarget(self, action: #selector(incrementButtonDown), for: .touchDown)
        incrementButton.addTarget(self, action: #selector(ActionButtonUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    
    @objc private func decrementButtonDown() {
        changeNumber(buttonAction: .decrement)
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(decrement), userInfo: nil, repeats: true)
    }
    
    
    @objc private func decrement(){
        changeNumber(buttonAction: .decrement)
    }
    
    
    @objc private func ActionButtonUp() {
        timer.invalidate()
    }
    
    
    @objc private func incrementButtonDown() {
        changeNumber(buttonAction: .increment)
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(increment), userInfo: nil, repeats: true)
    }
    
    
    @objc private func increment(){
        changeNumber(buttonAction: .increment)
    }
    
    
    private func changeNumber(buttonAction: ButtonAction) {
        guard let text = numberTextField.text, Int(text) != nil || text == "" else { return }
        
        var number = Int(text) == nil ? 0 : Int(text)!
        switch buttonAction {
        case .decrement:
            guard number > 0 else { timer.invalidate(); return }
            number -= 1
        case .increment:
            number += 1
        }
        numberTextField.resignFirstResponder()
        numberTextField.text = "\(number)"
        textFieldDidChange()
    }
    
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func animateNumberTFBorder(animationType: AnimationType) {
        let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = numberTextField.layer.borderWidth
        numberTextField.layer.add(borderWidthAnimation, forKey: "borderWidth")
        switch animationType {
        case .fadeIn:
            borderWidthAnimation.toValue = 1
            borderWidthAnimation.duration = 0.15
            numberTextField.layer.borderWidth = 1
            
        case .fadeOut:
            borderWidthAnimation.toValue = 0
            borderWidthAnimation.duration = 0.15
            numberTextField.layer.borderWidth = 0
        }
    }
    
    
    private func clearTextFieldsAndLabels(){
        numberTextField.text?.removeAll()
        calculatedLabel.text?.removeAll()
        usedAlgrorithmLabel.text?.removeAll()
    }
    
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc private func keyboardWillAppear(_ notification: NSNotification) {
        let key = UIResponder.keyboardFrameEndUserInfoKey
        guard let value = notification.userInfo?[key] as? NSValue else { return }
        
        let keyboardHeight          = value.cgRectValue.height
        decrementButton.transform   = CGAffineTransform(translationX: 0, y: -keyboardHeight + tabBarHeight)
        incrementButton.transform   = CGAffineTransform(translationX: 0, y: -keyboardHeight + tabBarHeight)
    }
    
    
    @objc private func keyboardWillDisappear() {
        decrementButton.transform = .identity
        incrementButton.transform = .identity
    }
    
    
    private func layoutUI() {
        let padding: CGFloat = 20
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            signLabel.centerYAnchor.constraint(equalTo: numberTextField.centerYAnchor),
            signLabel.leadingAnchor.constraint(equalTo: numberTextField.trailingAnchor),
            signLabel.widthAnchor.constraint(equalToConstant: 40),
            signLabel.heightAnchor.constraint(equalToConstant: 60),

            calculatedLabel.centerYAnchor.constraint(equalTo: signLabel.centerYAnchor),
            calculatedLabel.leadingAnchor.constraint(equalTo: signLabel.trailingAnchor),
            calculatedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            calculatedLabel.heightAnchor.constraint(equalToConstant: 60),

            numberTextField.topAnchor.constraint(equalTo: margins.topAnchor, constant: padding),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            numberTextField.widthAnchor.constraint(equalToConstant: 70),
            numberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            usedAlgrorithmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usedAlgrorithmLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usedAlgrorithmLabel.heightAnchor.constraint(equalToConstant: 80),
            usedAlgrorithmLabel.topAnchor.constraint(equalTo: signLabel.bottomAnchor, constant: 15),
            
            decrementButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -padding),
            decrementButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            decrementButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 35),
            decrementButton.heightAnchor.constraint(equalToConstant: 90),
            
            incrementButton.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -padding),
            incrementButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2 - 35),
            incrementButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            incrementButton.heightAnchor.constraint(equalToConstant: 90),
        ])
    }
}


extension PMFactorialVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEditingNumber = false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isEditingNumber = true
        clearTextFieldsAndLabels()
    }
}
