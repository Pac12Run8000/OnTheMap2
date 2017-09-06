//
//  UdacityAPIConvenience.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

extension UdacityAPIClient {

    func authenticateUdacityUser(_ email:String, _ password:String, completionHandlerForAuthenticateUser: @escaping (_ success:Bool, _ error:String)->()) {
    
        
        taskForPOSTSession(email, password) { (data, error) in
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse the data as JSON: '\(String(describing: data))'")
                completionHandlerForAuthenticateUser(false, "Could not parse the data as JSON:")
                return
            }
            
            guard let sessionDictionary = parsedResult["session"] as? [String:AnyObject] else {
                print("Can't find account! No Session Exists!")
                completionHandlerForAuthenticateUser(false, "Can't find account! No Session Exists!")
                return
            }
            
            guard let sessionId = sessionDictionary["id"] as? String else {
                print("No account ID.")
                completionHandlerForAuthenticateUser(false, "No account ID.")
                return
            }
            
            guard let accountDictionary = parsedResult["account"] as? [String:AnyObject] else {
                print("Can't find account!!")
                completionHandlerForAuthenticateUser(false, "Can't find account!!")
                return
            }
            guard let keyId = accountDictionary["key"] as? String else {
                print("No account ID.")
                completionHandlerForAuthenticateUser(false, "No account ID.")
                return
            }

            
            self.sessionID = sessionId
            self.accountID = keyId
            
            completionHandlerForAuthenticateUser(true, "")
            
            
//            print("sessionId:\(sessionId), keyId:\(keyId)")
        }
    }
    
    

}
