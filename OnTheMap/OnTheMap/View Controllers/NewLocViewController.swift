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
                let coordinates = placemark.location!.coordinate
                // Set only a single user in the student structure
                studentLoc.setUser(key: fakeInfo.key!, firstName: fakeInfo.firstName!, lastName: fakeInfo.lastName!,  mapString: self.locationField.text!, mediaURL: self.websiteField.text!, latitude: Float(coordinates.latitude), longitude: Float(coordinates.longitude))
                let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navVC")
                self.present(vc, animated: true)
            } else {
                if error!.localizedDescription.contains("2") {
                    let alertLogin = CentralData().popupAlert(alertT: "No Internet", alertMsg: "You seem to have poor internet connection", okText: "OK")
                    self.present(alertLogin, animated: true, completion: nil)
                    //"Check Internet Connectivity"
                } else {
                    let alertLogin = CentralData().popupAlert(alertT: "Bad Location", alertMsg: "This location couldn't be found, please try another one", okText: "OK")
                    self.present(alertLogin, animated: true, completion: nil)
                    //"Location Not Found"
                }
            }
        })
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
