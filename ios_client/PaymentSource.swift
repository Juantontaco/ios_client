//
//  PaymentSource.swift
//  ios_client
//
//  Created by Max Dignan on 5/27/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import SwiftyJSON

class PaymentSource {
    
    let sourceID:        String!
    let expirationMonth: String!
    let expirationYear:  String!
    let lastFourNumbers: String!
    let brand:           String!
    
    var isCard     = true
    var isApplePay = false
    var isFreeRide = false
    
    init(sourceID: String, expirationMonth: String, expirationYear: String, lastFourNumbers: String, brand: String) {
        
        self.sourceID = sourceID
        self.expirationMonth = expirationMonth
        self.expirationYear = expirationYear
        self.lastFourNumbers = lastFourNumbers
        self.brand = brand
    }
    
    init(json: JSON) {
        sourceID = json["id"].string
        
        if let card = json["card"].dictionary {
            expirationMonth = card["exp_month"]?.stringValue
            expirationYear =  card["exp_year"]?.stringValue
            lastFourNumbers = card["last4"]?.stringValue
            brand =           card["brand"]?.stringValue
        } else {
            print("an issue occured")
            
            expirationMonth = ""
            expirationYear =  ""
            lastFourNumbers = ""
            brand =           ""
        }
        
    }
    
    static func freeRide() -> PaymentSource {
        let instance = PaymentSource(sourceID: "freeride", expirationMonth: "0", expirationYear: "0", lastFourNumbers: "0000", brand: "0")
        
        instance.isCard = false
        instance.isApplePay = false
        
        instance.isFreeRide = true
        
        return instance
    }
    
    func cardToString() -> String {
        if isFreeRide {
            return "Free Ride!"
        } else {
            return "\(brand!) **** **** **** \(lastFourNumbers!) Exp: \(expirationMonth!)/\(expirationYear!)"
        }
    }
}
