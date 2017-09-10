//
//  ParseAPIConvenience.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit


extension ParseAPIClient {

    func getStudentLocation(completionHandlerToGetUserLocation: @escaping (_ success:Bool, _ error:String)->()) {
        
        taskForGETStudentLocation { (data, err) in
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Couldn't parse Json")
                completionHandlerToGetUserLocation(false, "Couldn't parse Json")
                return
            }
            
            guard let locationsDictionary = parsedResult["results"] as? [[String:AnyObject]] else {
                print("No Key Value pair in the result set.")
                
                completionHandlerToGetUserLocation(false, "No Key Value pair in the result set.")
                return
            }
            
            ParseAPIClient.sharedInstance().currentUserLocation = Location.locationsFromResults(results: locationsDictionary)
            
            completionHandlerToGetUserLocation(true, "")
        }
        
        
    }
    
    
    func getStudentLocations(completionHandlerToGetLocations: @escaping (_ success:Bool, _ error:String)->()) {
        
        taskForGETStudentLocations { (data, err) in
            
            
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {

                completionHandlerToGetLocations(false, "Could not parse JSON Data:\(String(describing: data))")
                return
                
            }
            
            guard let resultsDictionary = parsedResult["results"] as? [[String:AnyObject]] else {

                completionHandlerToGetLocations(false, "Can't find results dictionary.")
                return
            }

            if (self.currentUserLocation != nil) {
                var userLocations = Location.locationsFromResults(results: resultsDictionary)
                let location = self.currentUserLocation?[0]
                userLocations.append(location!)
                ParseAPIClient.sharedInstance().allLocations = userLocations
            } else {
                 ParseAPIClient.sharedInstance().allLocations = Location.locationsFromResults(results: resultsDictionary)
            }
                 ParseAPIClient.sharedInstance().allLocations?.sort(by: { (value1:Location, value2:Location) -> Bool in
                                                            return value1.updatedAt! > value2.updatedAt!
                 })
            
            completionHandlerToGetLocations(true, "")
            
        }
    }
    
    func addStudentLocation() {
        taskToPOSTUserLocationData() { (success, err) in
            
        }
    }
    
    func updateStudentLocation(completionForUpdate: @escaping (_ success:Bool?)->()) {
        taskForPUTUserLocationData() { (success, err) in
            completionForUpdate(true)
        }
    }
    


}
