//
//  NewLocViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/10/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class NewLocViewController: UIViewController{
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test cases
        //putStudentLocation(key: "1234", firstname: "John", lastname: "Doe", mapString: "Mountain View, CA", mediaURL: "https://udacity.com", latitude: 37.386052, longitude: -122.083851, objID: "8ZExGR5uX8")
    }
    //what to do when user hits find location
    @IBAction func findLocation(_ sender: Any) {
        let geoCoder = CLGeocoder()
        let address = locationField.text!
        geoCoder.geocodeAddressString(address, completionHandler: {(placemarks,error) in
        if let placemark = placemarks?.first {
        var coordinates = placemark.location!.coordinate
            CentralData().postStudentLocation(key: fakeInfo.key!, firstname: fakeInfo.firstName!, lastname: fakeInfo.lastName!, mapString: self.locationField.text!, mediaURL: self.websiteField.text!, latitude: Float(coordinates.latitude), longitude: Float(coordinates.longitude))
        } else {
            if error!.localizedDescription.contains("2") {
                self.websiteField.text = "NO INTERNET CONNECTION"
                self.locationField.text = "NO INTERNET CONNECTION"
                //"Check Internet Connectivity"
            } else {
                self.websiteField.text = "LOCATION NOT FOUND"
                self.locationField.text = "LOCATION NOT FOUND"
                //"Location Not Found"
            }
            }
        })
    }
}
/*
 CentralData().postStudentLocation(key: fakeInfo.key!, firstname: fakeInfo.firstName!, lastname: fakeInfo.lastName!, mapString: locationField.text!, mediaURL: websiteField.text!, latitude: 100, longitude: 100)
 let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navVC")
 present(vc, animated: true)
 */
