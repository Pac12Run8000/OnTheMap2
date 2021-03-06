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
    
        
        taskForPOSTSession(email, password) { (data, response, error) in
            
            if (error != nil) {
                if let errMsg = String(describing: error!) as? String {
                    completionHandlerForAuthenticateUser(false, errMsg)
                }
                return
            }
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse the data as JSON: '\(String(describing: data))'")
                completionHandlerForAuthenticateUser(false, "Could not parse the data as JSON:")
                return
            }
            
            guard let sessionDictionary = parsedResult[UdacityAPIClient.Constants.OTM.URLRequestKeys.Session] as? [String:AnyObject] else {
                print("Can't find account! No Session Exists!")
                completionHandlerForAuthenticateUser(false, "Can't find account! No Session Exists!")
                return
            }
            
            guard let sessionId = sessionDictionary[UdacityAPIClient.Constants.OTM.URLRequestKeys.ID] as? String else {
                print("No account ID.")
                completionHandlerForAuthenticateUser(false, "No account ID.")
                return
            }
            
            guard let accountDictionary = parsedResult[UdacityAPIClient.Constants.OTM.URLRequestKeys.Account] as? [String:AnyObject] else {
                print("Can't find account!!")
                completionHandlerForAuthenticateUser(false, "Can't find account!!")
                return
            }
            guard let keyId = accountDictionary[UdacityAPIClient.Constants.OTM.URLRequestKeys.Key] as? String else {
                print("No account ID.")
                completionHandlerForAuthenticateUser(false, "No account ID.")
                return
            }

            
            self.sessionID = sessionId
            self.accountID = keyId
            
            completionHandlerForAuthenticateUser(true, "")
            
        }
    }
    
    func logOutUdacityUser(completionHandlerForLogOut: @escaping (_ success:Bool?,_ error:String?)->()) {
        UdacityAPIClient.sharedInstance().taskForDELETESession { (data, response, err) in
            if (err == nil) {
                completionHandlerForLogOut(true, nil)
            } else {
                completionHandlerForLogOut(false, err?.localizedDescription)
            }
        }
    }
    
    func getPublicUserData(completionForGettingPublicUser: @escaping (_ success: Bool?, _ error:String?)->()) {
        
        guard let accountID = UdacityAPIClient.sharedInstance().accountID else {
            return
        }
        
        taskForGETPublicUserData(accountID) { (data, err) in
            
            let parsedResult:[String:AnyObject]!
            
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Couldn't properly parse JSON.")
                completionForGettingPublicUser(false, "Couldn't properly parse JSON.")
                return
            }
            
            guard let userDictionary = parsedResult[UdacityAPIClient.Constants.OTM.URLRequestKeys.User] as? [String:AnyObject] else {
                print("There is no user dictionary.")
                completionForGettingPublicUser(false, "There is no user dictionary.")
                return
            }
            
            guard let firstName = userDictionary[UdacityAPIClient.Constants.OTM.URLRequestKeys.FirstName] as? String else {
                print("Could not retrieve first name.")
                completionForGettingPublicUser(false, "Could not retrieve first name.")
                return
            }
            
            guard let lastName = userDictionary[UdacityAPIClient.Constants.OTM.URLRequestKeys.LastName] as? String else {
                print("Could not retrieve last name.")
                completionForGettingPublicUser(false, "Could not retrieve last name.")
                return
            }
            
//            print("parsed result:\(parsedResult)")
            
            self.firstName = firstName
            self.lastName = lastName
            completionForGettingPublicUser(true, nil)
            
        }
    
    }

}
