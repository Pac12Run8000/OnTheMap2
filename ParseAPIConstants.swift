//
//  ParseAPIConstants.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit


extension ParseAPIClient {
    
    struct Constants {
        
        struct OTM {
            
            struct Parse {
                static let ApiScheme = "https"
                static let ApiHost = "parse.udacity.com"
                static let ApiPathLocations = "/parse/classes/StudentLocation"
                
            }
        }
        
    }


}

extension ParseAPIClient {
    
    func getParseComponentsStudentLocations() -> String? {
        
        var component = URLComponents()
        component.scheme = ParseAPIClient.Constants.OTM.Parse.ApiScheme
        component.host = ParseAPIClient.Constants.OTM.Parse.ApiHost
        component.path = ParseAPIClient.Constants.OTM.Parse.ApiPathLocations
        
        
//        return "https://parse.udacity.com/parse/classes/StudentLocation?limit=100"
        return "\(String(describing: component.url!))?limit=100"
    }
    
    func getParseComponentsLocation() -> String? {
        var component = URLComponents()
        component.scheme = ParseAPIClient.Constants.OTM.Parse.ApiScheme
        component.host = ParseAPIClient.Constants.OTM.Parse.ApiHost
        component.path = ParseAPIClient.Constants.OTM.Parse.ApiPathLocations
        
        var QueryStringComponent = URLComponents()
      
            QueryStringComponent.path = "where={\"uniqueKey\":\"\(String(describing: UdacityAPIClient.sharedInstance().accountID!))\"}"
        
        
        if let url = component.url, let qUrl = QueryStringComponent.url {
            
            return "\(url)?\(qUrl)"
        } else {
            return nil
        }
        
       
    }

}
