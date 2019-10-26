//
//  TipsViewController.swift
//  Mortgage Buddy
//
//  Created by Lambda_School_Loaner_201 on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attributedString = textView.attributedText.mutableCopy() as! NSMutableAttributedString
        attributedString.addAttributes([.foregroundColor: UIColor.label], range: NSRange(location: 0, length: attributedString.length))
        
        textView.attributedText = attributedString

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
