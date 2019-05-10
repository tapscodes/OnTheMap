//
//  NavViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/10/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
import UIKit
class NavViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //lougout button pressed
    @IBAction func lougoutPressed(_ sender: Any) {
        delSession()
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
        present(vc, animated: true)
    }
    //refresh button pressed
    @IBAction func refreshPressed(_ sender: Any) {
    }
    //add location pressed
    @IBAction func newLocPressed(_ sender: Any) {
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newVC")
        present(vc, animated: true)
    }
    //logs user out
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
            let range = Range(5..<data!.count)
            let newData = data?.subdata(in: range) /* subset response data! */
            print(String(data: newData!, encoding: .utf8)!)
        }
        task.resume()
    }
}
