//
//  ChangePasswordViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/20/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var setNewPasswordButton: UIButton!
    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordField: UITextField!
    @IBOutlet weak var newPasswordAgainField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradient()
        showLogo()
        
        setNewPasswordButton.addBorder()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setNewPasswordPressed(_ sender: Any) {
        
        let currentPassword : String = currentPasswordField.text!
        let newPassword : String = newPasswordField.text!
        let newPasswordAgain : String = newPasswordAgainField.text!
        
        if currentPassword.count != 0 && newPassword.count != 0 && newPasswordAgain.count != 0 {
            
            if newPassword == newPasswordAgain {
                
                NetworkHelper().changePassword(oldPassword: currentPassword, newPassword: newPassword, completion: { worked in
                    
                    if worked {
                        self.toastMessage(message: "Password Updated!", danger: false)
                    } else {
                        self.toastMessage(message: "Password Failed To Update!", danger: true)
                    }
                })
            } else {
                toastMessage(message: "Please Provide Matching Passwords", danger: false)
            }
        } else {
            toastMessage(message: "Please Provide Passwords", danger: false)
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
