//
//  TabViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/10/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
import UIKit
class TabViewController: UITabBarController{
    //brings you to screen to add a new location
    @IBAction func newLoc(_ sender: Any) {
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newVC")
        present(vc, animated: true)
    }
    //refreshes map+list
    @IBAction func refresh(_ sender: Any) {
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navVC")
        present(vc, animated: true)
    }
    //logs user out
    @IBAction func logOut(_ sender: Any) {
        CentralData().delSession()
        let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginVC")
        present(vc, animated: true)
    }
}
