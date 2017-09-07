//
//  ParseAPIConvenience.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit


extension ParseAPIClient {

    func getStudentLocation(completionHandlerForAuthenticateUser: @escaping (_ success:Bool, _ error:String)->()) {
        
        taskForGETStudentLocation { (success, errmsg) in
            
        }
        
        
    }
    
    
    func getStudentLocations(completionHandlerForAuthenticateUser: @escaping (_ success:Bool, _ error:String)->()) {
        
        taskForGETStudentLocations { (success, errmsg) in
            
        }
        
        
    }
    


}
