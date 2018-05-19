//
//  ViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/18/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        signInButton.layer.borderWidth = 2
        signInButton.layer.cornerRadius = 15
        signInButton.layer.borderColor = UIColor.white.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func signInPressed(_ sender: Any) {
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        
        let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        
    self.navigationController?.pushViewController(signUpViewController!, animated: true)

    }
    
}

