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
