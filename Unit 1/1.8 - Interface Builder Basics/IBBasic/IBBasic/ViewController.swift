//
//  ViewController.swift
//  IBBasic
//
//  Created by 김태현 on 2022/08/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myButton.setTitleColor(.red, for: .normal)
    }
    @IBAction func buttonPressed(_ sender: Any) {
        print("The button was pressed")
    }
    

}

