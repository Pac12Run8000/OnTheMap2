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
    
    func taskForPUTUserLocationData(completionHandlerForPUTUserLocation:@escaping (_ success:Bool, _ errorMsg:String?)->()) {
        let location = currentUserLocation
        let objectId = location?[0].objectId
        let urlString = getParseComponentsToAddStudentLocation()! + "/" + objectId!
        let url = URL(string: urlString)
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"10094933264\", \"firstName\": \"Norbert\", \"lastName\": \"Grover\",\"mapString\": \"monument CO\", \"mediaURL\": \"http://apple.com\",\"latitude\": 39.09158, \"longitude\": -104.8682}".data(using: String.Encoding.utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if ((error) != nil) { // Handle error…
                print("There was an error with url request.")
                completionHandlerForPUTUserLocation(false, "There was an error with url request.")
                return
            }
            
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            completionHandlerForPUTUserLocation(true, nil)
        }
        task.resume()
        
    }
    
    func taskToPOSTUserLocationData(completionHandlerForPOSTUserLocation: @escaping (_ success:Bool, _ errorMsg:String?)->()) {
        let request = NSMutableURLRequest(url: URL(string: getParseComponentsToAddStudentLocation()!)!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"10094933264\", \"firstName\": \"Norbert\", \"lastName\": \"Grover\",\"mapString\": \"monument CO\", \"mediaURL\": \"http://wired.com\",\"latitude\": 39.09158, \"longitude\": -104.8682}".data(using: String.Encoding.utf8)
        session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) { // Handle error…
                print("There was an error with url request.")
                completionHandlerForPOSTUserLocation(false, "There was an error with url request.")
                return
            }
            
            
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
            
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
