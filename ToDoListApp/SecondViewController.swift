//
//  SecondViewController.swift
//  ToDoListApp
//
//  Created by Kisu on 2022-11-12.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.layer.borderWidth = 1
    }
    
    
}
