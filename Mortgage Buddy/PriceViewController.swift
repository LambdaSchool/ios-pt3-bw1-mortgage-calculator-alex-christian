//
//  PriceViewController.swift
//  Mortgage Buddy
//
//  Created by Lambda_School_Loaner_201 on 10/22/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PriceViewController: UIViewController {
    
    
    @IBOutlet weak var yourIncomeTextField: UITextField!
    
    @IBOutlet weak var spouseIncomeTextField: UITextField!
    
    @IBOutlet weak var totalIncomeTextView: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var affordablePrice: UILabel!
    
    @IBOutlet weak var calculateOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateOutlet.layer.cornerCurve = .continuous
        calculateOutlet.layer.cornerRadius = 20
        yourIncomeTextField.delegate = self
        spouseIncomeTextField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)        // Do any additional setup after loading the view.
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
    
    
    @IBAction func totalIncomeTimes3(_ sender: UIButton) {
        print("You just tapped me")
        hideKeyBoard()
        guard let yourIncomeString = yourIncomeTextField.text, !yourIncomeString.isEmpty, let yourIncome = Double(yourIncomeString) else { return }
        guard let spouseIncomeString = spouseIncomeTextField.text, !spouseIncomeString.isEmpty, let spouseIncome = Double(spouseIncomeString) else {return}
        //guard let totalIncome = totalIncomeTextView.text else {return false}
        var startingPrice = 0
        var newTotal = yourIncome + spouseIncome
        var homeTotal = newTotal * 3
        affordablePrice.text = "$\(homeTotal)"
    }
    
    
       
    func hideKeyBoard() {
        yourIncomeTextField.resignFirstResponder()
        spouseIncomeTextField.resignFirstResponder()
    }
    

    
    
    
}
    
extension PriceViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           hideKeyBoard()
           return false
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            // Hello, Wor
            //           ^l
            // Hello, Worl
            
            guard var yourIncomeString = yourIncomeTextField.text else { return false }
            guard var spouseIncomeString = spouseIncomeTextField.text else { return false }
            
            switch textField {
            case yourIncomeTextField:
                yourIncomeString = yourIncomeString.replacingCharacters(in: Range(range, in: yourIncomeString)!, with: string)
            case spouseIncomeTextField:
                spouseIncomeString = spouseIncomeString.replacingCharacters(in: Range(range, in: spouseIncomeString)!, with: string)
            default:
                break
            }
            
            if yourIncomeString.isEmpty || spouseIncomeString.isEmpty {
                totalIncomeTextView.text = ""
                return true
            }
            
            guard let yourIncome = Double(yourIncomeString) else {return false}
            guard let spouseIncome = Double(spouseIncomeString) else {return false}
            //guard let totalIncome = totalIncomeTextView.text else {return false}
            var startingPrice = 0
            var newTotal = yourIncome + spouseIncome

            // set the label
            totalIncomeTextView.text = "$\(newTotal)"


            return true
        
            func textFieldDidBeginEditing(_ textField: UITextField) {
                   let textFieldFrame = scrollView.convert(textField.bounds, from: textField)
                   
                   scrollView.scrollRectToVisible(textFieldFrame, animated: true)
           
            func textFieldDidEndEditing(_ textField: UITextField) {
               print(textField.text)
            
                }
                
            }
       
        }

    }
    
}


