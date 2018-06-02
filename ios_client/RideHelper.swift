//
//  RideHelper.swift
//  ios_client
//
//  Created by Max Dignan on 5/22/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import SwiftyJSON
import GoogleMaps

class RideHelper {
    
    static let shared: RideHelper! = {
        return RideHelper()
    }()
    
    var isInRide : Bool = false
    var rideId : String!
    
    func checkIfInRide(callback: @escaping (Bool, String) -> Void) {
        NetworkHelper().checkIfInRide(completion: { inRide, ride_id in
            self.isInRide = inRide
            self.rideId = ride_id
            
            callback(self.isInRide, ride_id)
        })
    }
    
    func calculateRideDistance(ridePingLocations: [JSON]) -> String {
        
        var distanceInMeters = 0.0
        
        let coordinates = ridePingLocations.map({rpl -> CLLocation in
            
            let coordinate : CLLocation = CLLocation(latitude: CLLocationDegrees(exactly: rpl["latitude"].doubleValue)!, longitude: CLLocationDegrees(exactly: rpl["longitude"].doubleValue)!)
            
            return coordinate
        })
        
        for index in 0...(coordinates.count - 2) {
            let c1 : CLLocation = coordinates[index]
            let c2 : CLLocation = coordinates[index + 1]
            
            distanceInMeters += c1.distance(from: c2)
        }
        
        let distanceInMiles = Measurement(value: distanceInMeters, unit: UnitLength.meters)
        
        return MeasurementFormatter().string(from: distanceInMiles)
    }
    
    func elapsedTime(ride: JSON) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = TimeZone.current
        
        let start = formatter.date(from: ride["created_at"].stringValue)
        let end = formatter.date(from: ride["end_time"].stringValue)
        
        let difference = Calendar.current.dateComponents([.minute, .second], from: start!, to: end!)
        
        return "\(difference.minute!)m\(difference.second!)s"
    }
    
    
}
