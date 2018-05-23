//
//  LocationHelper.swift
//  ios_client
//
//  Created by Max Dignan on 5/22/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class LocationHelper : NSObject  , CLLocationManagerDelegate {
    
    static let shared: LocationHelper! = {
        return LocationHelper()
    }()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location : CLLocation = locations[0]
        
        self.currentLocation = location
    }
    
}

