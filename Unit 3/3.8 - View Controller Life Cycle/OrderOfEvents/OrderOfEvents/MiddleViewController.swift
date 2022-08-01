//
//  MiddleViewController.swift
//  OrderOfEvents
//
//  Created by 김태현 on 2022/07/20.
//

import UIKit

class MiddleViewController: UIViewController {

    @IBOutlet weak var middleViewLabel: UILabel!
    var eventNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent number \(eventNumber) was viewDidLoad"
            eventNumber += 1
            // Do any additional setup after loading the view.
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent number \(eventNumber) was viewWillAppear"
            eventNumber += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent number \(eventNumber) was viewDidAppear"
            eventNumber += 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent number \(eventNumber) was viewWillDisapear"
            eventNumber += 1
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent number \(eventNumber) was viewDidDisappear"
            eventNumber += 1
        }
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
