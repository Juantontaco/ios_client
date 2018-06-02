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
import Locksmith

extension UIButton {
    func addBorder() {
        layer.borderWidth = 2
        layer.cornerRadius = 15
        layer.borderColor = UIColor.white.cgColor
    }
    
    func addPurpleBorder() {
        addBorder()
        layer.borderColor = UIColor.purple.cgColor
    }
}

extension UIViewController {
    
    static let topOffset = 10
    
    func addVerticalGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        
        let pink = UIColor(red: 227 / 255, green: 111 / 255, blue: 244 / 255, alpha: 1.0).cgColor
        let royalPurple = UIColor(red: 113 / 255, green: 58 / 255, blue: 158 / 255, alpha: 1.0).cgColor
        
        gradientLayer.colors = [pink, royalPurple]
        
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func addVerticleGradientTopBar() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 75)
        
        
        let pink = UIColor(red: 227 / 255, green: 111 / 255, blue: 244 / 255, alpha: 1.0).cgColor
        let royalPurple = UIColor(red: 113 / 255, green: 58 / 255, blue: 158 / 255, alpha: 1.0).cgColor
        
        gradientLayer.colors = [pink, royalPurple]
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func showMenu() {
        
        let menuButton = UIButton()
        
        menuButton.frame = CGRect(x: 5, y: UIViewController.topOffset + 7, width: 70, height: 70)
        
        menuButton.setImage(UIImage(named: "hamburgerMenu"), for: .normal)
        
        
        menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        
        
        self.view.addSubview(menuButton)
    }
    
    func showLogo() {
        let logo : UIImage = #imageLiteral(resourceName: "zoot_logo")
        
        let width = 150
        let height = 70
        
        let rect = CGRect(x: Int((self.view.bounds.width / 2) - (CGFloat.init(width) / 2)), y: UIViewController.topOffset, width: width, height: height)
        
        let logoView = UIImageView(image: logo)
        
        logoView.frame = rect
        
        
        
        if (Locksmith.loadDataForUserAccount(userAccount: "user") != nil) && Locksmith.loadDataForUserAccount(userAccount: "user")!["Access-Token"] != nil {
            
            let gestureRec = UITapGestureRecognizer(target: self, action: #selector(homeButtonPressed))
            
            gestureRec.numberOfTapsRequired = 1
            
            logoView.isUserInteractionEnabled = true
            
            logoView.addGestureRecognizer(gestureRec)
        }
        
        self.view.addSubview(logoView)
    }
    
    @objc func homeButtonPressed() {
        print("home button pressed")
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        
        homeViewController?.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        
        
        self.present(homeViewController!, animated: true, completion: nil)
        
        self.removeFromParentViewController()
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
    
    func showBlackBar(withText: String) {
        let blackBarLabel = UILabel(frame: CGRect(x: 0, y: 75, width: self.view.bounds.width, height: 25))
        
        blackBarLabel.backgroundColor = .black
        blackBarLabel.textAlignment = .center
        blackBarLabel.font = UIFont(name: "Gill Sans", size: 15)
        blackBarLabel.text = withText
        blackBarLabel.textColor = .white
        
        self.view.addSubview(blackBarLabel)
    }
    
    func showWhiteBottomBox() -> UIView {
        let heightOfBox : CGFloat = 100.0
        
        let view = UIView(frame: CGRect(x: 0, y: self.view.bounds.height - heightOfBox, width: self.view.bounds.width, height: heightOfBox))
        
        view.backgroundColor = .white
        
        self.view.addSubview(view)
        
        return view
    }
    
    func fillScooterInfoBox() {
        //TODO:: Scooter image not showing
        
        let whiteBoxView : UIView = showWhiteBottomBox()
        let heightOfBox : CGFloat = whiteBoxView.bounds.height
        
        let scooterImageViewCGRect = CGRect(x: 0, y: self.view.bounds.height - heightOfBox, width: 70, height: 70)
        let scooterImageView = UIImageView(frame: scooterImageViewCGRect)
        
        scooterImageView.image = UIImage(named: "Zooter Icon")
        scooterImageView.image?.draw(in: scooterImageViewCGRect)
        
        whiteBoxView.addSubview(scooterImageView)
    }
}

extension UIImage {
    func resizeImage(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        self.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
