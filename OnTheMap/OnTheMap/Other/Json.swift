//
//  Json.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/8/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
//Login Info
struct Login: Codable{
    let account: Account
    let session: Session
}
struct Session: Codable{
    let id: String
    let expiration: String
}
struct Account: Codable{
    let registered: Bool
    let key: String
}
//Student Location Info
struct StudentLocation: Codable{
    let locationID: String?
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float
    init(_ dictionary: [String: AnyObject]) {
        self.locationID = dictionary["objectId"] as? String
        self.uniqueKey = dictionary["uniqueKey"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.mapString = dictionary["mapString"] as? String ?? ""
        self.mediaURL = dictionary["mediaURL"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? Float ?? 0.0
        self.longitude = dictionary["longitude"] as? Float ?? 0.0
    }
        var fullName: String {
            var name = ""
            if !firstName.isEmpty {
                name = firstName
            }
            if !lastName.isEmpty {
                if name.isEmpty {
                    name = lastName
                } else {
                    name += " \(lastName)"
                }
            }
            if name.isEmpty {
                name = "No name provided"
            }
            return name
        }
    }
    //Student Info
    struct StudentInformation {
        
    }
