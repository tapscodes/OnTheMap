//
//  NewLocViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/10/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
import UIKit
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
        postStudentLocation(key: fakeInfo.key!, firstname: fakeInfo.firstName!, lastname: fakeInfo.lastName!, mapString: locationField.text!, mediaURL: websiteField.text!, latitude: 37.386052, longitude: -122.083851)
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navVC")
        present(vc, animated: true)
    }
    //posts student location info
    func postStudentLocation(key: String, firstname: String, lastname: String, mapString: String, mediaURL: String, latitude: Float, longitude: Float){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(key)\", \"firstName\": \"\(firstname)\", \"lastName\": \"\(lastname)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
    //puts student location info
    func putStudentLocation(key: String, firstname: String, lastname: String, mapString: String, mediaURL: String, latitude: Float, longitude: Float, objID: String){
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation/\(objID)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "PUT"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"uniqueKey\": \"\(key)\", \"firstName\": \"\(firstname)\", \"lastName\": \"\(lastname)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
    }
}
