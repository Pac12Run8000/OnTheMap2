//
//  ParseAPIClient.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

class ParseAPIClient: NSObject {

    var session = URLSession.shared
    
    
    func taskForGETStudentLocation(completionHandlerForTaskForPOSTSession: @escaping (_ data: Data?, _ error: NSError?)->()) {
        let url = URL(string: getParseComponentsLocation()!)
        print("url:\(String(describing: url!))")
    }
    
    func taskForGETStudentLocations(completionHandlerForTaskForPOSTSession: @escaping (_ data: Data?, _ error: NSError?)->()) {
        
    }
    
    
    class func sharedInstance() -> ParseAPIClient {
        struct Singleton {
            static var sharedInstance = ParseAPIClient()
        }
        return Singleton.sharedInstance
    }
}
