//
//  ViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/1/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import UIKit
//LOGIN VIEW CONTROLLER
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginCheck: UILabel!
    //login variable to check if user has logged in
    var login = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up text fields
        userField.delegate = self
        passField.delegate = self
    }
    func changeText(text: String){
        loginCheck.text = text
    }
    //tries to log user in with login info given by user
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
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            //print(String(data: newData!, encoding: .utf8)!)
            do {
                let decoder = JSONDecoder()
                let loginInfo = try decoder.decode(Login.self, from: newData!)
                print(loginInfo)
                self.login=true
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    //what happens when login button is pressed
    @IBAction func loginPressed(_ sender: Any) {
        //attempts to log in user
        sessionID(username: userField.text!, password: passField.text!)
        //checks if login was successful
        if(login){
        self.changeText(text: "Login Succeeded!")
        //loads up map
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navVC") 
        present(vc, animated: true)
        //resets login to false
        login=false
        }//if login fails
        else{
        self.changeText(text: "Login Failed. Try Again.")
        }
    }
}

