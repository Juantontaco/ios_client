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
        let subdata = data["data"] as! NSDictionary
        print(data)
        
        do {
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: "user")
            
            if dictionary == nil {
                try Locksmith.saveData(data: [
                    "Access-Token": response.response?.allHeaderFields["Access-Token"] as Any,
                    "Client": response.response?.allHeaderFields["Client"] as Any,
                    "Expiry": response.response?.allHeaderFields["Expiry"] as Any,
                    "uid": subdata["uid"] as Any,
                    "email": subdata["email"] as Any,
                    "name": subdata["name"] as Any
                ], forUserAccount: "user")
            } else {
                do {
                    try Locksmith.updateData(data: ["Access-Token": response.response?.allHeaderFields["Access-Token"] as Any], forUserAccount: "user")
                } catch let error as NSError {
                    print(error)
                }
                
                do {
                    try Locksmith.updateData(data: ["Client": response.response?.allHeaderFields["Client"] as Any], forUserAccount: "user")
                } catch let error as NSError {
                    print(error)
                }
                
                do {
                    try Locksmith.updateData(data: ["Expiry": response.response?.allHeaderFields["Expiry"] as Any], forUserAccount: "user")
                } catch let error as NSError {
                    print(error)
                }
                
                do {
                    try Locksmith.updateData(data: ["uid": subdata["uid"] as Any], forUserAccount: "user")
                } catch let error as NSError {
                    print(error)
                }
                
                do {
                    try Locksmith.updateData(data: ["email": subdata["email"] as Any], forUserAccount: "user")
                } catch let error as NSError {
                    print(error)
                }
                
                do {
                    try Locksmith.updateData(data: ["name": subdata["name"] as Any], forUserAccount: "user")
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
    
    func signUp(name: String, email : String, password: String, completion: @escaping (Bool) -> Void) {
        
        signInOrSignUp(signIn: false, name: name, email: email, password: password, completion: completion)
    }
    
    func signIn(email : String, password: String, completion: @escaping (Bool) -> Void) {
        
        signInOrSignUp(signIn: true, name: "", email: email, password: password, completion: completion)
    }
}
