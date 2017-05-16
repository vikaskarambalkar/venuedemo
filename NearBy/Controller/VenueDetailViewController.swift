//
//  VenueDetailViewController.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    var selectedVenue : Venue?
    static let identifire = "VenueDetailViewController"

    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    
    static func loadFromNib(venue: Venue) -> VenueDetailViewController {
        
        let venueDetail = mainStoryBoard.instantiateViewController(withIdentifier: identifire) as! VenueDetailViewController
        venueDetail.selectedVenue = venue
        return venueDetail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = selectedVenue?.name
        address.text = selectedVenue?.location.formattedAddress.joined()
    }
}
