//
//  ViewController.swift
//  FillButton
//
//  Created by shima jinsei on 2016/11/06.
//  Copyright © 2016年 Jinsei Shima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: FillButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        if button.isSelected {
            print("button selected")
        } else {
            print("button not selected")
        }
    }
    
}

