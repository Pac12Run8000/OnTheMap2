//
//  Location.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/7/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import Foundation
import UIKit




struct Location {
    let createdAt: String?
    var firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId: String?
    let uniqueKey: String?
    let updatedAt: String?
    
    init(dictionary: [String:AnyObject]) {
        
        createdAt = dictionary["createdAt"] as? String
        firstName = dictionary["firstName"] as? String
        lastName = dictionary["lastName"] as? String
        latitude = dictionary["latitude"] as? Double
        longitude = dictionary["longitude"] as? Double
        mapString = dictionary["mapString"] as? String
        mediaURL = dictionary["mediaURL"] as? String
        objectId = dictionary["objectId"] as? String
        uniqueKey = dictionary["uniqueKey"] as? String
        updatedAt = dictionary["updatedAt"] as? String
    }
    
    static func locationsFromResults( results: [[String:AnyObject]]) -> [Location] {
        var location = [Location]()
        
        for result in results {
            location.append(Location(dictionary: result))
        }
        return location
    }
}

extension Location: Equatable {

    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.objectId == rhs.objectId
    }
}

var currentUserLocation:[Location]? = nil

var allLocations:[Location]? = nil


