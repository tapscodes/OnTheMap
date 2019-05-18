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
struct StudentResponse: Codable{
    var results: [StudentLocation]
}
struct StudentLocation: Codable{
    var locationID: String?
    var uniqueKey: String?
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Float?
    var longitude: Float?
    var fullName: String{
        var name = "No name given"
        if(firstName != nil){
        name = firstName!
            if(lastName != nil){
            name += " "
            name += lastName!
            }
        }else{
            if(lastName != nil){
                name = lastName!
            }
        }
        return name
    }
    var realURL: String{
        var URL = "nowesbite.com"
        if(mediaURL != nil ){
            URL = mediaURL!
        }
        return URL
    }
}
//Student Info
struct StudentInformation {
    
}
