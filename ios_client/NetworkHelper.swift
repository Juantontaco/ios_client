//
//  NetworkHelper.swift
//  ios_client
//
//  Created by Max Dignan on 5/18/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import Foundation
import Alamofire
import Locksmith

class NetworkHelper {
    let DOMAIN = "https://ridezoot-server.herokuapp.com"
    
    func updateAuthData(rawSuccessData: Any, response: DataResponse<Any>) {
        let data = rawSuccessData as! NSDictionary
        let subdata = data["data"] as? NSDictionary
        print(data)
        
        do {
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: "user")
            
            
            
            if dictionary == nil {
                
                try Locksmith.saveData(data: [
                    "Access-Token": response.response?.allHeaderFields["Access-Token"] as! String,
                    "Client": response.response?.allHeaderFields["Client"] as! String,
                    "Expiry": response.response?.allHeaderFields["Expiry"] as! String,
                    "uid": subdata!["uid"] as! String,
                    "email": subdata!["email"] as! String,
                    "name": subdata!["name"] as! String
                ], forUserAccount: "user")
            } else {
                do {
                    try Locksmith.saveData(data: [
                        "Access-Token": response.response?.allHeaderFields["Access-Token"] as! String,
                        "Client": response.response?.allHeaderFields["Client"] as! String,
                        "Expiry": response.response?.allHeaderFields["Expiry"] as! String,
                        "uid": dictionary!["uid"] as! String,
                        "email": dictionary!["email"] as! String,
                        "name": dictionary!["name"] as! String,
                        ], forUserAccount: "user")
                } catch let error as NSError {
                    print(error)
                }
            }
            
            
        } catch {
            print("Error")
        }
    }
    
    func signInOrSignUp(signIn: Bool, name: String, email : String, password: String, completion: @escaping (Bool) -> Void) {
        let params : Parameters = ["name": name, "email": email, "password": password, "password_confirmation": password, "confirm_success_url": "/confirm"]
        
        var route = "/auth"
        if signIn {
            route = "/auth/sign_in"
        }
        
        Alamofire.request(DOMAIN + route, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            
            switch response.result {
            case .success(let raw):
                
                
                let data = raw as! NSDictionary
                if data["errors"] != nil {
                    return completion(false)
                } else {
                    self.updateAuthData(rawSuccessData: raw, response: response)
                    
                    completion(true)
                }
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    func getHeaders() -> HTTPHeaders {
        let dictionary = Locksmith.loadDataForUserAccount(userAccount: "user")
        
        let headers : HTTPHeaders = [
            "access-token": dictionary!["Access-Token"] as! String,
            "client":       dictionary!["Client"] as! String,
            "expiry":       dictionary!["Expiry"] as! String,
            "uid":          dictionary!["uid"] as! String,
            "token-type":   "Bearer"
        ]
        
        return headers
    }
    
    func signUp(name: String, email : String, password: String, completion: @escaping (Bool) -> Void) {
        
        signInOrSignUp(signIn: false, name: name, email: email, password: password, completion: completion)
    }
    
    func signIn(email : String, password: String, completion: @escaping (Bool) -> Void) {
        
        signInOrSignUp(signIn: true, name: "", email: email, password: password, completion: completion)
    }
    
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping (Bool) -> Void) {
        
        let headers : HTTPHeaders = getHeaders()
        
        Alamofire.request(DOMAIN + "/auth/password?password=\(newPassword)&password_confirmation=\(newPassword)", method: .put, headers: headers).responseJSON(completionHandler: { response in

            switch response.result {
            case .success(let raw):


                let data = raw as! NSDictionary
                
                if data["errors"] != nil {
 
                    return completion(false)
                } else {


                    completion(true)
                }

            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    func checkIfInRide(completion: @escaping (Bool) -> Void) {
        let headers : HTTPHeaders = getHeaders()
        
        Alamofire.request(DOMAIN + "/users/check_if_in_ride.json", method: .get, headers: headers).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let raw):
                
                
                let data = raw as! NSDictionary
                
                if data["in_ride"] != nil && data["in_ride"] as! Bool == true {

                    return completion(true)
                } else {
                    return completion(false)
                }
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    func getScooters(completion: @escaping ([Scooter]) -> Void) {
        let headers : HTTPHeaders = getHeaders()
        
        Alamofire.request(DOMAIN + "/scooters.json", method: .get, headers: headers).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let raw):
                
                
                let data = raw as! NSDictionary
                
                if data["scooters"] != nil {

                    let scooters : [Scooter] = {
                        return (data["scooters"] as! [NSDictionary] ).compactMap({ scooter in
                            return Scooter(dictionary: scooter)
                        })
                    }()
                    return completion(scooters)
                } else {
                    return completion([])
                }
                
            case .failure(let error):
                print(error)
                completion([])
            }
        })
    }
    
    func getScooterBySpecialIDCode(specialIDCode: String, completion: @escaping (Scooter?) -> Void) {
        let headers : HTTPHeaders = getHeaders()
        
        Alamofire.request(DOMAIN + "/scooters/\(specialIDCode).json", method: .get, headers: headers).validate().responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(let raw):
                
                
                let data = raw as! NSDictionary
                
                if data["scooter"] != nil && (data["scooter"] as! NSDictionary?) != nil {
                    let scooter : Scooter = {
                        return Scooter(dictionary: data["scooter"] as! NSDictionary)
                    }()
                    return completion(scooter)
                } else {
                    return completion(nil)
                }
                
            case .failure(let error):
                print(error)
                completion(nil)
            }
        })
    }
}
