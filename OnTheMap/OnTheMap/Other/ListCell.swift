//
//  ListCell.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/10/19.
//  Copyright © 2019 TAPS. All rights reserved.
//

import Foundation
import UIKit
class ListCell: UITableViewCell {
    static let identifier = "LocCell"
    
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    func configWith(_ info: (/*Insert Student Info Here*/)) {
        nameLabel.text = info.labelName
        websiteLabel.text = info.mediaURL
    }
}
