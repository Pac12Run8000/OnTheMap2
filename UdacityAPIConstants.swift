//
//  UdacityAPIConstants.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

extension UdacityAPIClient {

    struct Constants {
        
        struct OTM {
            
            struct Udacity {
                static let ApiScheme = "https"
                static let ApiHost = "www.udacity.com"
                static let ApiPathSession = "/api/session"
                static let ApiPathGetPublicUsers = "/api/users/"
            }
        }
        
        

        
    }

}

extension UdacityAPIClient {
    
    func OTMUrlFromLoginFields(username:String,password:String) -> String {
        return "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
    }
    
    func getUdacityComponentsPublicUserData() -> URLComponents {
        var component = URLComponents()
        component.scheme = UdacityAPIClient.Constants.OTM.Udacity.ApiScheme
        component.host = UdacityAPIClient.Constants.OTM.Udacity.ApiHost
        component.path = UdacityAPIClient.Constants.OTM.Udacity.ApiPathGetPublicUsers
        
        return component
    }
    
    
    func getUdacityComponentsForAuth() -> URLComponents {
        var component = URLComponents()
        component.scheme = UdacityAPIClient.Constants.OTM.Udacity.ApiScheme
        component.host = UdacityAPIClient.Constants.OTM.Udacity.ApiHost
        component.path = UdacityAPIClient.Constants.OTM.Udacity.ApiPathSession
        
        return component
    }
    
    

}
