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
    var locs = studentLoc.getStudentResp()!.results
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CALLED")
        studentLoc.getStudentLocation()
        tableView.delegate = self
        tableView.dataSource = self
    }
     func didSelectLocation(info: StudentLocation) {
        let app = UIApplication.shared
        app.open(URL(string: info.realURL)!, options: [:], completionHandler: nil)
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
