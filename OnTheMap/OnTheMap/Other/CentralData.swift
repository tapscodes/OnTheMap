//
//  CentralData.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/18/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import UIKit
import Foundation
//model class for student location array
var studentLoc: CentralData = CentralData()

class CentralData{
    var studentResp: StudentResponse?
    
    //gets student location info from parse
    func getStudentLocation(loadingIsDone:@escaping ()->()){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
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
                self.studentResp = try decoder.decode(StudentResponse?.self, from: data!)
                //prints first name
                //print(self.studentResp?.results[0].firstName)
                DispatchQueue.main.async { loadingIsDone() }
            } catch {
                print(error)
                DispatchQueue.main.async { loadingIsDone() }
            }
        }
        task.resume()
    }
    //gets student info for one student
    func getSpecificStudent(key: String){
        let urlString = "https://parse.udacity.com/parse/classes/StudentLocation?uniqueKey=\(key)"
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
        waitForCompletion(task: task)
    }
    func getStudentResp() -> StudentResponse?{
        return studentResp
    }
    //gets a users FAKE session info
    func getFakeID(id: String){
        let request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/users/\(id)")!)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            //print(String(data: newData!, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                fakeInfo = try decoder.decode(FakeInfo.self, from: newData!)
                print(fakeInfo)
            } catch {
                print(error)
            }
        }
        task.resume()
        waitForCompletion(task: task)
    }
    //tries to log user in with login info given by user and sets "login" to true
    func sessionID(username: String, password: String){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // encoding a JSON body from a string, can also use a Codable struct
        request.httpBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            //print(String(data: newData!, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                loginInfo = try decoder.decode(Login.self, from: newData!)
                //print(loginInfo.account.key)
                login = true
            } catch {
                print(error)
            }
        }
        task.resume()
        waitForCompletion(task: task)
    }
    //deletes user session
    func delSession(){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let range = (5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
        waitForCompletion(task: task)
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
        waitForCompletion(task: task)
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
        waitForCompletion(task: task)
    }
    //updates activity view and waits for function to complete
    func waitForCompletion(task: URLSessionDataTask){
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activity.hidesWhenStopped = false
        activity.startAnimating()
        while (task.state==URLSessionTask.State.running) { sleep(1) }
        activity.stopAnimating()
    }
    //pops up an alert message
    func popupAlert(alertT: String, alertMsg: String, okText: String) -> UIAlertController{
        let alert = UIAlertController(title: alertT, message: alertMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: okText, style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)}))
        return alert
    }
}
