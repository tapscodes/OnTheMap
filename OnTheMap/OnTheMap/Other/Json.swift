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
}

