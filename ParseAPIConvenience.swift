//
//  ParseAPIConvenience.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit


extension ParseAPIClient {

    func getStudentLocation(completionHandlerForGetUserLocation: @escaping (_ success:Bool, _ error:String)->()) {
        
        taskForGETStudentLocation { (data, err) in
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Couldn't parse Json")
                completionHandlerForGetUserLocation(false, "Couldn't parse Json")
                return
            }
            
            guard let locationsDictionary = parsedResult["results"] as? [[String:AnyObject]] else {
                print("No Key Value pair in the result set.")
                
                completionHandlerForGetUserLocation(false, "No Key Value pair in the result set.")
                return
            }
            
            ParseAPIClient.sharedInstance().currentUserLocation = Location.locationsFromResults(results: locationsDictionary)
            
           completionHandlerForGetUserLocation(true, "")

            
            
            
            
        }
        
        
    }
    
    
    func getStudentLocations(completionHandlerForAuthenticateUser: @escaping (_ success:Bool, _ error:String)->()) {
        
        taskForGETStudentLocations { (success, errmsg) in
            
        }
        
        
    }
    


}
