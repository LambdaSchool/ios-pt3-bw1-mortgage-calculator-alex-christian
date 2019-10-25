//
//  PriceViewController.swift
//  Mortgage Buddy
//
//  Created by Lambda_School_Loaner_201 on 10/22/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class PriceViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var yourIncomeTextField: UITextField!
    
    @IBOutlet weak var spouseIncomeTextField: UITextField!
    
    @IBOutlet weak var totalIncomeTextView: UILabel!
    
    
    @IBOutlet weak var affordablePrice: UILabel!
    
    
    @IBAction func totalIncomeTimes3(_ sender: UIButton) {
        print("You just tapped me")
        guard let yourIncomeString = yourIncomeTextField.text, !yourIncomeString.isEmpty, let yourIncome = Double(yourIncomeString) else {return}
        guard let spouseIncomeString = spouseIncomeTextField.text, !spouseIncomeString.isEmpty, let spouseIncome = Double(spouseIncomeString) else {return}
        //guard let totalIncome = totalIncomeTextView.text else {return false}
        var startingPrice = 0
        var newTotal = yourIncome + spouseIncome
        var homeTotal = newTotal * 3
        affordablePrice.text = "$\(homeTotal)"
}
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }

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
    }
}
