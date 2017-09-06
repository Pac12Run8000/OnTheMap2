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
        
        
        }
    }

}
