//
//  MortgageCalculationsViewController.swift
//  Mortgage Buddy
//
//  Created by Alex Thompson on 10/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class MortgageCalculationsViewController: UIViewController {
    
    
    @IBOutlet weak var homeValueTextField: UITextField!
    @IBOutlet weak var downPaymentTextField: UITextField!
    @IBOutlet weak var totalLoanTextField: UITextField!
    @IBOutlet weak var homeValueLabel: UILabel!
    @IBOutlet weak var downPaymentLabel: UILabel!
    @IBOutlet weak var loanAmountLabel: UILabel!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var calculateOutlet: UIButton!
    
    @IBOutlet weak var interestRateTextField: UITextField!
    
    
//MARK: -Below textfield for picker, and its constant/variable:
    @IBOutlet weak var termTextField: UITextField!
    
    let pvPress: [(name: String, numb: Int)] = [("15 Years Fixed", 15), ("30 Years Fixed", 30)]
    
    var selectedTerm: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTermPicker()
        createToolbar()
        
        
        calculateOutlet.layer.cornerRadius = 20
        calculateOutlet.layer.cornerCurve = .continuous
        
        homeValueTextField.delegate = self
        downPaymentTextField.delegate = self
        totalLoanTextField.delegate = self
        interestRateTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardRectInScrollView = view.convert(keyboardRect, from: nil)
        
        let screenIntersection = view.bounds.height - keyboardRectInScrollView.origin.y
        
        var scrollViewInsets = scrollView.contentInset
        
        scrollViewInsets.bottom = screenIntersection
        
        scrollView.contentInset = scrollViewInsets
        scrollView.scrollIndicatorInsets = scrollViewInsets
    }
    
    func hideKeyBoard() {
        homeValueTextField.resignFirstResponder()
        downPaymentTextField.resignFirstResponder()
        totalLoanTextField.resignFirstResponder()
        interestRateTextField.resignFirstResponder()
        
        
        
        
    }
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print("calculate button tapped")
        hideKeyBoard()
        
        guard let homeValueString = homeValueTextField.text, !homeValueString.isEmpty, let homeValue = Double(homeValueString) else {return}
        
        guard let downPaymentString = downPaymentTextField.text, !downPaymentString.isEmpty, let downPayment = Double(downPaymentString) else {return}
        
        guard let interestRateString = interestRateTextField.text, !interestRateString.isEmpty, let interestRate = Double(interestRateString) else {return}
        
        var startingDown = 0
        var totalLoan = homeValue - downPayment
        let calculateInterest = interestRate / 100 / 1.5 * totalLoan
        let fifteenInterest = calculateInterest * 15 + totalLoan
        let thirtyInterest = calculateInterest * 30 + totalLoan
        let fifteenYearTerm = convertDoubleToCurrency(amount: fifteenInterest / 180)
        let thirtyYearTerm = convertDoubleToCurrency(amount: thirtyInterest  / 360)
        if selectedTerm == "15 Years Fixed" {
            answerLabel.text = ("You're Mortgage Payment will be \(fifteenYearTerm) a month for the next 15 years")
        }
        
        if selectedTerm == "30 Years Fixed" {
            answerLabel.text = ("You're Mortgage Payment will be \(thirtyYearTerm) a month for the next 30 years")
        }
//        let homeValue = NSString(string: homeValueTextField.text!).doubleValue
//        let downPayment = NSString(string: downPaymentTextField.text!).doubleValue
//        var totalLoan = NSString(string: totalLoanTextField.text!).doubleValue
//        totalLoan.text = homeValue - downPayment
//        let monthlyPayment = convertDoubleToCurrency(amount: totalLoan * calculateInterest * 30 / 360)
//        answerLabel.text = monthlyPayment
        
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print(textField.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard var homeValueString = homeValueTextField.text else {return false}
        guard var downPaymentString = downPaymentTextField.text else {return false}
        
        switch textField {
        case homeValueTextField:
            homeValueString = homeValueString.replacingCharacters(in: Range(range, in: homeValueString)!, with: string)
        case downPaymentTextField:
            downPaymentString = downPaymentString.replacingCharacters(in: Range(range, in: downPaymentString)!, with: string)
        default:
            break
        }
        
        if homeValueString.isEmpty || downPaymentString.isEmpty {
            totalLoanTextField.text = ""
            return true
        }
        guard let homeValue = Double(homeValueString) else {return false}
        guard let downPayment = Double(downPaymentString) else {return false}
        
        var startingDown = 0
        var totalLoan = convertDoubleToCurrency(amount: homeValue - downPayment)
        totalLoanTextField.text = totalLoan
        
        return true
    }
    
    
    func convertCurrenctToDouble(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter.number(from: input)?.doubleValue
    }
    
    func convertDoubleToCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
}

extension MortgageCalculationsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           hideKeyBoard()
           return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            let textFieldFrame = scrollView.convert(textField.bounds, from: textField)
            
            scrollView.scrollRectToVisible(textFieldFrame, animated: true)
    }
    
//MARK:     //Function to create the picker:
    func createTermPicker() {
        let termPicker = UIPickerView()
        termPicker.delegate = self
        
        termTextField.inputView = termPicker
        
        //Customization for picker:
        termPicker.backgroundColor = .black
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Customization for toolbar:
        toolbar.barTintColor = .black
        toolbar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(MortgageCalculationsViewController.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        termTextField.inputAccessoryView = toolbar
    }
    
    
    
}


extension MortgageCalculationsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pvPress.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pvPress[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedTerm = pvPress[row].name
        termTextField.text = selectedTerm
        
    }
    
    //Customization for the text color on picker:
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        }else {
            label = UILabel()
        }
        
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Menlo-Regular", size: 17)
        label.text = pvPress[row].name
        
        return label
    }
    
    
}
