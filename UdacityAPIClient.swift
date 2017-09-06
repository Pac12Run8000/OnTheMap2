//
//  UdacityAPIClient.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

class UdacityAPIClient: NSObject {
    
    var accountID:String? = nil
    var sessionID:String? = nil
    var firstName:String? = nil
    var lastName:String? = nil
    
    
    
    
    
    var session = URLSession.shared
    
    
    
    func taskForPOSTSession(_ email:String, _ password:String, completionHandlerForTaskForPOSTSession: (_ data: Data?, _ error: NSError?)->()) {
        
        print("login url: \(getUdacityComponentsForAuth())")
        
        
        
//        let request = NSMutableURLRequest(url: URL(string: UdacityClient.Constants.UdacityAuthUrl.AuthUrl)!)
//        request.httpMethod = "POST"
        
//        request.addValue(UdacityClient.Constants.UDacityAPIKeys.Application_JSON, forHTTPHeaderField: UdacityClient.Constants.UDacityAPIValues.Application_JSON_Accept)
//        request.addValue(UdacityClient.Constants.UDacityAPIKeys.Application_JSON, forHTTPHeaderField: UdacityClient.Constants.UDacityAPIValues.Application_JSON_ContentType)
//        request.httpBody = appDelegate.OTMUrlFromLoginFields(username: username, password: password).data(using: String.Encoding.utf8)
//        
//        let session = URLSession.shared
//        let task = session.dataTask(with: request as URLRequest) { data, response, error in
//            
//        }
        
    }
    
    func taskForDELETESession(completionHanderForTaskForDELETESesion: (_ data: Data?, _ error: NSError?)->()) {
        
    }
    
    func taskForGETPublicUserData(_ accountID:String, completionHandlerForGETPublicUserData: (_ data: Data?, _ error: NSError?)->()) {
        
    }
    
    
    
    
    
    class func sharedInstance() -> UdacityAPIClient {
        struct Singleton {
            static var sharedInstance = UdacityAPIClient()
        }
        return Singleton.sharedInstance
    }
}
