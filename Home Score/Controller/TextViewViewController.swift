//
//  TextViewViewController.swift
//  Home Score
//
//  Created by Joshua Ford on 3/28/21.
//

import UIKit

class TextViewViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    var text: String?
    
    override func viewDidLoad() {
        textView.text = text!
    }
}
