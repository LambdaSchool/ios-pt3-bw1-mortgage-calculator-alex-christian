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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateOutlet.layer.cornerRadius = 20
        calculateOutlet.layer.cornerCurve = .continuous
        
        homeValueTextField.delegate = self
        downPaymentTextField.delegate = self
        totalLoanTextField.delegate = self
        
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
           
    }
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print("calculate button tapped")
        hideKeyBoard()
        let homeValue = NSString(string: homeValueTextField.text!).doubleValue
        let downPayment = NSString(string: downPaymentTextField.text!).doubleValue
        var totalLoan = NSString(string: totalLoanTextField.text!).doubleValue
        totalLoan = homeValue - downPayment
        answerLabel.text = ("You're monthly payment will be $\(totalLoan / 360) over a course of 30 years")
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
}
