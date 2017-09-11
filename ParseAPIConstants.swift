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
            struct APIConnectionKeys {
                static let AppIDKey = "X-Parse-Application-Id"
                static let RestAPIKey = "X-Parse-REST-API-Key"
                static let ContentTypeKey = "Content-Type"
            }
            struct APIConnectionValues {
                static let AppIDValue = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
                static let RestAPIValue = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
                static let ContentTypeValue = "application/json"
            }
            struct URLRequestKeys {
                static let UniquKey = "uniquekey"
                static let FirstName = "firstname"
                static let LastName = "lastname"
                static let MapString = "mapstring"
                static let MediaUrl = "mediaUrl"
                static let Latitude = "latitude"
                static let Longitude = "longitude"
            }
            struct URLRequestValues {
                
            }

        }
        
    }


}

extension ParseAPIClient {
    
    func getParseComponentsToAddStudentLocation() -> String? {
        var component = URLComponents()
        component.scheme = ParseAPIClient.Constants.OTM.Parse.ApiScheme
        component.host = ParseAPIClient.Constants.OTM.Parse.ApiHost
        component.path = ParseAPIClient.Constants.OTM.Parse.ApiPathLocations
        
        return String(describing: component.url!)
    }
    
    func getParseComponentsStudentLocations() -> String? {
        
        var component = URLComponents()
        component.scheme = ParseAPIClient.Constants.OTM.Parse.ApiScheme
        component.host = ParseAPIClient.Constants.OTM.Parse.ApiHost
        component.path = ParseAPIClient.Constants.OTM.Parse.ApiPathLocations

        let queryItem = URLQueryItem(name: "limit", value: "100")
        
        component.queryItems = [URLQueryItem]()
        component.queryItems?.append(queryItem)
        
        return String(describing: component.url!)
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
        }
        return nil
    }
}
