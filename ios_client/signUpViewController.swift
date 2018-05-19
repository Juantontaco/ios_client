//
//  signUpViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/18/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        NetworkHelper().signUp(email: emailField.text!, password: passwordField.text!, completion: { didWork in
            if didWork {
                print(didWork)
            } else {
                print("didNotWork")
            }
        })
    }
    
}
