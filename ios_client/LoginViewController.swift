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
        
        addVerticalGradient()
        showLogo()
        
        signInButton.addBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func signInPressed(_ sender: Any) {
        NetworkHelper().signIn(email: emailField.text!, password: passwordField.text!, completion: { didWork in
            if didWork {
                print("did sign into account")
                
                let accountViewController = self.storyboard?.instantiateViewController(withIdentifier: "AccountViewController") as? AccountViewController
                
//                self.navigationController?.setViewControllers([accountViewController!], animated: true)
                
                self.present(accountViewController!, animated: true, completion: nil)
            } else {
                print("didNotWork")
                self.toastMessage(message: "Login Credentials Invalid", danger: true)
            }
        })
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        
        let signUpViewController = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        
//        self.navigationController?.pushViewController(signUpViewController!, animated: true)
        
        self.present(signUpViewController!, animated: true, completion: nil)

    }
    
}

