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
    
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print("calculate button tapped")
        let homeValue = NSString(string: homeValueTextField.text!).doubleValue
        let downPayment = NSString(string: downPaymentTextField.text!).doubleValue
        var totalLoan = NSString(string: totalLoanTextField.text!).doubleValue
        totalLoan = homeValue - downPayment
        answerLabel.text = ("You're monthly payment will be $\(totalLoan / 360) over a course of 30 years")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }
    
  
}

extension MortgageCalculationsViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let text = textField.text,
            !text.isEmpty {
            switch textField {
            case homeValueTextField:
                downPaymentTextField.becomeFirstResponder()
            case downPaymentTextField:
                totalLoanTextField.becomeFirstResponder()
            default:
                textField.resignFirstResponder()
            }
        }
        
        return false
    }
}
