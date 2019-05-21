//
//  ListViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/2/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import UIKit
import Foundation
class ListViewController: UITableViewController {
    var locs : [StudentLocation] = [StudentLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentLoc.getStudentLocation()
        locs = studentLoc.getStudentResp()!.results
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let app = UIApplication.shared
        if (self.locs[(indexPath as NSIndexPath).row].realURL != "No Valid URL") {
        app.open(URL(string: self.locs[(indexPath as NSIndexPath).row].realURL)!, options: [:], completionHandler: nil)
        }else{
            let alertLogin = CentralData().popupAlert(alertT: "Bad URL", alertMsg: "This website can't be opened", okText: "OK")
            self.present(alertLogin, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 100
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocCell", for: indexPath) as! ListCell
        let info = self.locs[(indexPath as NSIndexPath).row]
        cell.nameLabel.text = info.fullName
        cell.websiteLabel.text = info.realURL
        return cell
    }
}
