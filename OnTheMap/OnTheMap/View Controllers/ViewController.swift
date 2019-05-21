//
//  ViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/1/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
//LOGIN/FAKE LOGIN INFO TO BE USED IN APP
var loginInfo: Login = Login(account: Account(registered: false, key: "no key"), session: Session(id: "no id", expiration: "no expiration"))
var fakeInfo: FakeInfo = FakeInfo(lastName: "No Last Name", firstName: "No First Name", key: "No Key")
//bool to check if logged in
var login = false

import UIKit
//LOGIN VIEW CONTROLLER
class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    //sets up default loginInfo
    var signupPage: String = "https://auth.udacity.com/sign-up?next=https://classroom.udacity.com/authenticated"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //sets up text fields
        userField.delegate = self
        passField.delegate = self
    }
    //what happens when login button is pressed
    @IBAction func loginPressed(_ sender: Any) {
        //attempts to log in user
        CentralData().sessionID(username: userField.text!, password: passField.text!)
        //checks if login was successful
        if(login){
        CentralData().getFakeID(id: loginInfo.account.key)
        //loads up map
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navVC") 
            present(vc, animated: true)
        //resets login to false
        login = false
        }//if login fails
        else{
        let alertLogin = CentralData().popupAlert(alertT: "Bad Login", alertMsg: "Please check your username and password", okText: "OK")
            self.present(alertLogin, animated: true, completion: nil)
        }
    }
    //what happens when signup is pressed
    @IBAction func signUpPressed(_ sender: Any) {
        let app = UIApplication.shared
        //opens udacity signup page
        app.open(URL(string: signupPage)!, options: [:], completionHandler: nil)
    }
}

