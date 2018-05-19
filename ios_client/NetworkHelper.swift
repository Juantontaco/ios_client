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
    
    func signInOrSignUp(signIn: Bool, email : String, password: String, completion: @escaping (Bool) -> Void) {
        let params : Parameters = ["email": email, "password": password, "password_confirmation": password, "confirm_success_url": "/confirm"]
        
        var route = "/auth"
        if signIn {
            route = "/auth/sign_in"
        }
        
        Alamofire.request(DOMAIN + route, method: .post, parameters: params).responseJSON(completionHandler: {
            response in
            
            switch response.result {
            case .success(let raw):
                completion(true)
                
                let data = raw as! NSDictionary
                let subdata = data["data"] as! NSDictionary
                print(data)
                
                do {
                    try Locksmith.saveData(data: ["Access-Token": response.response?.allHeaderFields["Access-Token"], "Client": response.response?.allHeaderFields["Client"], "Expiry": response.response?.allHeaderFields["Expiry"], "uid": subdata["uid"]], forUserAccount: "user")
                } catch {
                    print("Error")
                }
                
            case .failure(let error):
                print(error)
                completion(false)
            }
        })
    }
    
    func signUp(email : String, password: String, completion: @escaping (Bool) -> Void) {
        
        signInOrSignUp(signIn: false, email: email, password: password, completion: completion)
    }
    
    func signIn(email : String, password: String, completion: @escaping (Bool) -> Void) {
        
        signInOrSignUp(signIn: true, email: email, password: password, completion: completion)
    }
}
