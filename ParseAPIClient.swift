//
//  ParseAPIClient.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

class ParseAPIClient: NSObject {
    
    
    var currentUserLocation:[Location]? = nil
    
    var allLocations:[Location]? = nil
    
    // This is functionality for testing if the currentLocation has a value
    
//    if (self.currentUserLocation == nil) {
//    print("No Location")
//    } else {
//    print("You have a location.")
//    
//    }

    var session = URLSession.shared
    
    
    func taskForGETStudentLocation(completionHandlerForTaskForPOSTSession: @escaping (_ data: Data?, _ error: NSError?)->()) {
        let url = URL(string: getParseComponentsLocation()!)
        let request = NSMutableURLRequest(url: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print("An error occured during request.")
                completionHandlerForTaskForPOSTSession(nil, error as NSError?)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                completionHandlerForTaskForPOSTSession(nil, error as NSError?)
                return
            }
            
            completionHandlerForTaskForPOSTSession(data, nil)
        }
        task.resume()
        
    }
    
    func taskForGETStudentLocations(completionHandlerForTaskForPOSTSession: @escaping (_ data: Data?, _ error: NSError?)->()) {
        
        let url = URL(string: getParseComponentsStudentLocations()!)

        let request = NSMutableURLRequest(url: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                print("An error occured during request.")
                completionHandlerForTaskForPOSTSession(nil, error as NSError?)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                completionHandlerForTaskForPOSTSession(nil, error as NSError?)
                return
            }
            
            completionHandlerForTaskForPOSTSession(data, nil)
        }
        task.resume()

    
    
    }
    
    func taskToPOSTUserLocationData(params:[String:AnyObject], completionHandlerForPOSTUserLocation: @escaping (_ success:Bool, _ errorMsg:NSError?)->()) {
        let request = NSMutableURLRequest(url: URL(string: getParseComponentsToAddStudentLocation()!)!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(String(describing: params["uniquekey"]!))\", \"firstName\": \"\(String(describing: params["firstname"]!))\", \"lastName\": \"\(String(describing: params["lastname"]!))\",\"mapString\": \"\(String(describing: params["mapstring"]!))\", \"mediaURL\": \"\(String(describing: params["mediaUrl"]!))\",\"latitude\": \(String(describing: params["latitude"]!)), \"longitude\":\(String(describing: params["longitude"]!))}".data(using: String.Encoding.utf8)
        session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if ((error) != nil) { // Handle error…
                print("There was an error with url request.")
                completionHandlerForPOSTUserLocation(false, error as NSError?)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                completionHandlerForPOSTUserLocation(false, error as NSError?)
                return
            }
            
            completionHandlerForPOSTUserLocation(true, nil)
            
        }
        task.resume()
    }


    class func sharedInstance() -> ParseAPIClient {
        struct Singleton {
            static var sharedInstance = ParseAPIClient()
        }
        return Singleton.sharedInstance
    }
}
