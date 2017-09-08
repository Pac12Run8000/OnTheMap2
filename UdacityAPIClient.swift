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
    var objectId:String? = nil
    
    
    
    
    
    var session = URLSession.shared
    
    
    
    func taskForPOSTSession(_ email:String, _ password:String, completionHandlerForTaskForPOSTSession: @escaping (_ data: Data?, _ error: NSError?)->()) {
        
        
        let request = NSMutableURLRequest(url: URL(string: String(describing: getUdacityComponentsForAuth()))!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = UdacityAPIClient.sharedInstance().OTMUrlFromLoginFields(username: email, password: password).data(using: String.Encoding.utf8)
        session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                completionHandlerForTaskForPOSTSession(nil, error! as NSError)
                print("An error occured during request.")
                return
            }
            
                let range = Range(5..<data!.count)
                let newData = data?.subdata(in: range) /* subset response data! */
                
                
                print(NSString(data: newData!, encoding: String.Encoding.utf8.rawValue)!)
                completionHandlerForTaskForPOSTSession(newData, nil)
                
            
        }
        task.resume()
    }
    
    func taskForDELETESession(completionHanderForTaskForDELETESesion: (_ data: Data?, _ error: NSError?)->()) {
        
    }
    
    func taskForGETPublicUserData(_ accountID:String?, completionHandlerForGETPublicUserData: @escaping (_ data: Data?, _ error: NSError?)->()) {
        

        
        let url = URL(string: String(describing: getUdacityComponentsPublicUserData()) + accountID!)!
        let request = NSMutableURLRequest(url: url)
        session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil { // Handle error...
                print("An error occured during request.")
                completionHandlerForGETPublicUserData(nil, error! as NSError)
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                completionHandlerForGETPublicUserData(nil, error! as NSError)
                return
            }
            
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range)
            
//            print("newData:\(String(describing: newData))")
            
            completionHandlerForGETPublicUserData(newData, nil)
        }
        task.resume()
            
        
        
    }
    
    
    
    
    
    class func sharedInstance() -> UdacityAPIClient {
        struct Singleton {
            static var sharedInstance = UdacityAPIClient()
        }
        return Singleton.sharedInstance
    }
}
