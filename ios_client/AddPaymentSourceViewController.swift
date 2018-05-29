//
//  AddPaymentSourceViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/26/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Stripe

class AddPaymentSourceViewController: UIViewController, STPPaymentCardTextFieldDelegate {
    
    var shouldHaveBackButton: Bool = false
    
    @IBOutlet var paymentButton: UIButton!
    
    let paymentCardTextField = STPPaymentCardTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addVerticalGradient()
        showLogo()
        addCreditCardField()
        paymentButton.addBorder()
        
        paymentButton.setTitleColor(.gray, for: .normal)
        paymentButton.layer.borderColor = UIColor.gray.cgColor
        
        if self.shouldHaveBackButton {
            showLeftBackButton()
        }
        
        
    }
    
    func showLeftBackButton() {
        
        let backButtonRect = CGRect(x: 15, y: UIViewController.topOffset + 25, width: 30, height: 30)
        let image = UIImage(named: "backButtonLeft")
        image?.draw(in: backButtonRect)
        
        let leftBackButton = UIButton(frame: backButtonRect)
        leftBackButton.setImage(image, for: .normal)
        
        leftBackButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        
        self.view.addSubview(leftBackButton)
    }
    
    func addCreditCardField() {
        paymentCardTextField.frame = CGRect(x: 0, y: (view.bounds.height / 2), width: view.bounds.width, height: 44)
        
        paymentCardTextField.backgroundColor = .white
        paymentButton.layer.borderColor = UIColor.white.cgColor
        
        paymentCardTextField.delegate = self
        
        view.addSubview(paymentCardTextField)
        view.bringSubview(toFront: paymentCardTextField)
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        
        paymentButton.isEnabled = textField.isValid
        
        if textField.isValid {
            paymentButton.setTitleColor(.white, for: .normal)
            paymentButton.layer.borderColor = UIColor.white.cgColor
        } else {
            paymentButton.setTitleColor(.gray, for: .normal)
            paymentButton.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBAction func addPaymentButtonPressed(_ sender: Any) {
        
        paymentButton.isEnabled = false
        self.toastMessage(message: "Saving Card to Stripe", danger: true)
        
        if paymentCardTextField.isValid {
            let cardParams = STPCardParams()

            cardParams.number = paymentCardTextField.cardNumber
            cardParams.expMonth = paymentCardTextField.expirationMonth
            cardParams.expYear = paymentCardTextField.expirationYear
            cardParams.cvc = paymentCardTextField.cvc
            
            let sourceParams = STPSourceParams.cardParams(withCard: cardParams)
            STPAPIClient.shared().createSource(with: sourceParams) { (source, error) in
                if let s = source, s.flow == .none && s.status == .chargeable {
                    // TODO : hit backend
                    
                    print(s)
                    
                    NetworkHelper().addPaymentSource(sourceID: s.stripeID, completion: { didWork in
                        
                        if didWork {
                            self.goBackToPaymentSources()
                        } else {
                            self.toastMessage(message: "Error Saving Card to Stripe Server", danger: true)
                            self.paymentButton.isEnabled = true
                        }
                    })
                } else {
                    print("Error:")
                    print(error)
                    self.toastMessage(message: "Error Validating Card", danger: true)
                    self.paymentButton.isEnabled = true
                }
            }
        }
    }
    
    @objc func backButtonPressed() {
        goBackToPaymentSources()
    }
    
    func goBackToPaymentSources() {
//        let paymentSourcesVC : PaymentSourcesViewController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentSourcesViewController") as! PaymentSourcesViewController
//
//        paymentSourcesVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//
//        self.present(paymentSourcesVC, animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
