//
//  LABViewController.swift
//  Hello
//
//  Created by 김태현 on 2022/07/13.
//

import UIKit

class LABViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func setTextButtonTapped(_ sender: Any) {
        if let inputText = textField.text {
            textLabel.text = inputText
        }
        textField.resignFirstResponder()
    }
    @IBAction func clearTextButtonTapped(_ sender: Any) {
        textLabel.text = ""
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
