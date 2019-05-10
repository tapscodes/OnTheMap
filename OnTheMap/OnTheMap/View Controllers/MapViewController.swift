//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/2/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import UIKit
import Foundation
import CoreLocation
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        //getMapData()
        getStudentLocation()
        //POST+PUT TESTER: WORKED
        //postStudentLocation(key: "1234", firstname: "John", lastname: "Doe", mapString: "Mountain View, CA", mediaURL: "https://udacity.com", latitude: 37.386052, longitude: -122.083851)
        //putStudentLocation(key: "1234", firstname: "John", lastname: "Doe", mapString: "Mountain View, CA", mediaURL: "https://udacity.com", latitude: 37.386052, longitude: -122.083851, objID: "8ZExGR5uX8")
    }
    //INFO FUNCTIONS
    //gets fake student data from Udacity API
    func getMapData(){
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/3903878747")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
    //gets student location info from parse
    func getStudentLocation(){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            //print(String(data: data!, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                let studentLoc = try decoder.decode(StudentLocation.self, from: data!)
                print(studentLoc)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    //gets student info for one student
    func getSpecificStudent(){
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error
                return
            }
            print(String(data: data!, encoding: .utf8)!)
        }
        task.resume()
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
    //MAP FUNCTIONS
    
}
