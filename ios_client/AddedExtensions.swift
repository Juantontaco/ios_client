//
//  AddedExtensions.swift
//  ios_client
//
//  Created by Max Dignan on 5/20/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import UIKit
import Toast_Swift

extension UIButton {
    func addBorder() {
        layer.borderWidth = 2
        layer.cornerRadius = 15
        layer.borderColor = UIColor.white.cgColor
    }
}

extension UIViewController {
    func addVerticalGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        
        let pink = UIColor(red: 227 / 255, green: 111 / 255, blue: 244 / 255, alpha: 1.0).cgColor
        let royalPurple = UIColor(red: 113 / 255, green: 58 / 255, blue: 158 / 255, alpha: 1.0).cgColor
        
        gradientLayer.colors = [pink, royalPurple]
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func showMenu() {
        
        let menuButton = UIButton()
        
        menuButton.frame = CGRect(x: 5, y: 7, width: 70, height: 70)
        
        menuButton.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        
        
        menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        
        
        self.view.addSubview(menuButton)
    }
    
    func showLogo() {
        let logo : UIImage = #imageLiteral(resourceName: "zoot_logo")
        
        let width = 150
        let height = 70
        
        let rect = CGRect(x: Int((self.view.bounds.width / 2) - (CGFloat.init(width) / 2)), y: 0, width: width, height: height)
        
        let logoView = UIImageView(image: logo)
        
        logoView.frame = rect
        
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(homeButtonPressed))
        
        gestureRec.numberOfTapsRequired = 1
        
        logoView.isUserInteractionEnabled = true
        logoView.addGestureRecognizer(gestureRec)
        
        self.view.addSubview(logoView)
    }
    
    @objc func homeButtonPressed() {
        print("home button pressed")
    }
    
    @objc func menuButtonPressed() {
        let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        
        menuViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(menuViewController!, animated: true, completion: nil)
        
    }
    
    func toastMessage(message: String, danger: Bool) {
        var style = ToastStyle()
        
        style.maxWidthPercentage = 0.85
        
        if danger {
            style.messageColor = .white
            style.backgroundColor = .black
        } else {
            style.messageColor = .black
            style.backgroundColor = .white
        }
        
        self.view.makeToast(message, duration: 3.0, position: .bottom, style: style)
    }
}
