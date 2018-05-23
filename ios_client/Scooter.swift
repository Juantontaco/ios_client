//
//  Scooter.swift
//  ios_client
//
//  Created by Max Dignan on 5/22/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import CoreLocation

class Scooter {
    
    var specialIDCode: String!
    var battery: UInt!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    init(specialIDCode: String, battery: UInt, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        self.battery = battery
        self.specialIDCode = specialIDCode
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(dictionary: NSDictionary) {
        self.battery = dictionary["battery"] as! UInt
        self.specialIDCode = dictionary["special_id_code"] as! String
        self.latitude = dictionary["latitude"] as! CLLocationDegrees
        self.longitude = dictionary["longitude"] as! CLLocationDegrees
    }
}
