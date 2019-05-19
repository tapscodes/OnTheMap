//
//  CentralData.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/18/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
//model class for student location array
var studentLoc: CentralData = CentralData()

class CentralData{
    var studentResp: StudentResponse?
    //INFO FUNCTIONS
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
                self.studentResp = try decoder.decode(StudentResponse?.self, from: data!)
                //prints first name
                //print(self.studentResp?.results[0].firstName)
            } catch {
                print(error)
            }
        }
        task.resume()
        while (task.state==URLSessionTask.State.running) { sleep(1) }
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
    func getStudentResp() -> StudentResponse?{
        return studentResp
    }
}
