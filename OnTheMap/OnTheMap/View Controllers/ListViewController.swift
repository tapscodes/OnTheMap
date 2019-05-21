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
    var loaddone : Bool = false
    let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    
    func loadingIsDone() {
        loaddone = true
        locs = studentLoc.getStudentResp()!.results
        self.tableView.reloadData()
        self.myActivityIndicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        refreshData.DataDone=self.loadingIsDone
        refreshData.ActivityIndicator=myActivityIndicator
        super.viewDidLoad()
        loaddone = false
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = self.view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        
        self.view.addSubview(myActivityIndicator)
        studentLoc.getStudentLocation(loadingIsDone: loadingIsDone)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        refreshData.DataDone=self.loadingIsDone
        refreshData.ActivityIndicator=myActivityIndicator
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
        if (loaddone) {
            return 100
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocCell", for: indexPath) as! ListCell
        let info = self.locs[(indexPath as NSIndexPath).row]
        cell.nameLabel.text = info.fullName
        cell.websiteLabel.text = info.realURL
        return cell
    }
}
