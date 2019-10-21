//
//  BrowserViewController.swift
//  Mortgage Buddy
//
//  Created by Lambda_School_Loaner_201 on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webKitView: WKWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webKitView.navigationDelegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Home Search Options", style: .plain, target: self, action: #selector(openTapped))

        let url = URL(string:"https://Realtor.com")!
        webKitView.load(URLRequest(url: url))
        webKitView.allowsBackForwardNavigationGestures = true
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Google.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Realtor.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Trulia.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Zillow.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else {return}
        webKitView.load(URLRequest(url: url))
        
    }
   
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

}
