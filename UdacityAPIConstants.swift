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
            
            struct Parse {
                static let ApiScheme = "https"
                static let ApiHost = "parse.udacity.com"
                static let ApiPathLocations = "/parse/classes/StudentLocation"
            }
            
        }
        
        

        
    }


}
