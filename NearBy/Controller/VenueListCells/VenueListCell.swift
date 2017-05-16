//
//  VenueListCell.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import UIKit

class VenueListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationDetailLabel: UILabel!
    
    func setTitle(title: String, and locationDetail: String) {
        self.titleLabel.text = title
        self.locationDetailLabel.text = locationDetail
    }

}
