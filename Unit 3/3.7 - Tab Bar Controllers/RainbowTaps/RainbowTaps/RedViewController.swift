//
//  RedViewController.swift
//  RainbowTaps
//
//  Created by 김태현 on 2022/07/19.
//

import UIKit

class RedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tabBarItem.badgeValue = "1"
        
        
    
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sleep(1)
        tabBarItem.badgeValue = nil
        
    }

}

