//
//  RideSummaryViewController.swift
//  ios_client
//
//  Created by Max Dignan on 5/28/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Cosmos

class RideSummaryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var costLabel : UILabel!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var placeholderLabel : UILabel!
    var starView  : CosmosView!
    
    var rideId    : String!
    var cost      : Double!
    var rating    : Double = 4.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        showRide()
        showLogo()
        showMenu()
        addVerticleGradientTopBar()
        showBlackBar(withText: "Thanks for riding! Refer your friends for free rides!")
        
        setUpStars()
        
        setUpCommentTextView()
//        drawSubmitButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showRide() {
        costLabel.text = String(format: "Trip Cost: $%.02f", cost!)
    }
    
    func setUpStars() {
        let width : CGFloat = 250.0
        let height : CGFloat = 80.0
        
        let starView = CosmosView(frame: CGRect(x: (self.view.bounds.width / 2) - ( width / 2 ), y: (self.view.bounds.height / 2) - ( height / 2 ), width: width, height: height))
        
        starView.rating = 4
        starView.didFinishTouchingCosmos = { rating in
        
            self.rating = rating
            print(rating)
        }
        
        starView.settings.emptyColor = .lightGray
        starView.settings.filledColor = .yellow
        starView.center = self.view.center
        
        
        view.addSubview(starView)
    }
    
    func setUpCommentTextView() {

        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !commentTextView.text.isEmpty
        
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.borderWidth = 1

        
        commentTextView.delegate = self
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !commentTextView.text.isEmpty
    }
    
    func drawSubmitButton() {
        submitButton.layer.borderWidth = 2
        submitButton.layer.cornerRadius =  submitButton.bounds.height / 2
        submitButton.layer.borderColor = UIColor.purple.cgColor
        
        submitButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        self.submitButton.isEnabled = false
        
        let ratingAsInt : Int = Int(self.rating)
        
        print(self.commentTextView.text)
        print(self.rating)
        print(ratingAsInt)
        
        NetworkHelper().commentOnRide(rideId: self.rideId, star_count: ratingAsInt, comment: self.commentTextView.text, completion: { didWork in
            
            if didWork != nil {
                if didWork! {
                    let homeVC : HomeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    
                    homeVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                    
                    self.present(homeVC, animated: true, completion: nil)
                } else {
                    self.toastMessage(message: "Error submitting button.", danger: false)
                }
            } else {
                self.toastMessage(message: "Error submitting button.", danger: false)
            }
            
            self.submitButton.isEnabled = true
        })
    }
    

}
