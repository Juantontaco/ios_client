//
//  signUpViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/18/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addVerticalGradient()
        showLogo()
        
        signUpButton.layer.borderWidth = 2
        signUpButton.layer.cornerRadius = 15
        signUpButton.layer.borderColor = UIColor.white.cgColor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        let firstName: String = firstNameField.text!
        let lastName: String = lastNameField.text!
        
        NetworkHelper().signUp(name: "\(firstName) \(lastName)", email: emailField.text!, password: passwordField.text!, completion: { didWork in
            if didWork {
                print("did create account")
                
                let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
                
//                self.navigationController?.setViewControllers([accountViewController!], animated: true)
                
                self.present(accountViewController!, animated: true, completion: nil)
            } else {
                print("didNotWork")
            }
        })
    }
    
}
