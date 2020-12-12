//
//  ViewController.swift
//  SwiftToast
//
//  Created by Summit on 11/12/20.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func cancel(_ sender: Any) {
        passwordTextField.resignFirstResponder()
        Toastview.show(message: "Hellooo... World")
        userTextField.resignFirstResponder()
        
    }
    
    @IBAction func showToast(_ sender: Any) {
        Toastview.show(message: "Hi there..")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    
    
    

}

//extension ViewController: UITextFieldDelegate {
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        return true
//    }
//
//}

