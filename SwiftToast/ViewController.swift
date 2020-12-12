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
    
    
    @IBAction func createView(_ sender: Any) {
       
        Toastview.show(message: "Hellooo... World")
        userTextField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
    
    }
    
    
    

}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("i am in")
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
    }
    

}

