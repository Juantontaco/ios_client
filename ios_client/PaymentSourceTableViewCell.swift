//
//  PaymentSourceTableViewCell.swift
//  ios_client
//
//  Created by Max Dignan on 6/1/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Stripe

class PaymentSourceTableViewCell: UITableViewCell {
    
    @IBOutlet var cardImageView : UIImageView!
    @IBOutlet var last4Field: UILabel!
    @IBOutlet var expirationField: UILabel!
    
    var paymentSource : PaymentSource!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render() {
        
        if self.paymentSource.isCard {
            let cardBrand = STPCardValidator.brand(forNumber: "\(self.paymentSource.lastFourNumbers)")
            let cardImage = STPImageLibrary.brandImage(for: cardBrand)
            
            self.cardImageView.image = cardImage
            
            self.last4Field.text = "**** **** **** \(self.paymentSource.lastFourNumbers!)"
            
            self.expirationField.text = "Exp: \(self.paymentSource.expirationMonth!)/\(self.paymentSource.expirationYear!)"
        } else if self.paymentSource.isFreeRide {
            self.last4Field.text = "Free Ride!!"
            self.expirationField.text = ""
        } else if self.paymentSource.isApplePay {
            
        }
    }

}
