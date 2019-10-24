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
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print(textField.text)
//    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let yourIncomeString = yourIncomeTextField.text, !yourIncomeString.isEmpty, let yourIncome = Double(yourIncomeString) else {return false}
        guard let spouseIncomeString = spouseIncomeTextField.text, !spouseIncomeString.isEmpty, let spouseIncome = Double(spouseIncomeString) else {return false}
        //guard let totalIncome = totalIncomeTextView.text else {return false}
        var startingPrice = 0
        var newTotal = yourIncome + spouseIncome
        
        
        
        
        return true
    }
}
