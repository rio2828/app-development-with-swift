//
//  ViewController.swift
//  Light
//
//  Created by 김태현 on 2022/08/01.
//

import UIKit

class ViewController: UIViewController {
    
//    @IBOutlet weak var lightButton: UIButton!
    
    var lightOn = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        lightOn = !lightOn
        updateUI()
    }
    
    func updateUI() {
//        if lightOn {
//            self.view.backgroundColor = .white
//
//        } else {
//            self.view.backgroundColor = .black
//
//        }
        view.backgroundColor = lightOn ? .white : .black
    }
}

