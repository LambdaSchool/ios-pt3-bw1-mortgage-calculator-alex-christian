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
    
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print("calculate button tapped")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeValueLabel.textColor = .darkBlue //just messing with how the colors work

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
