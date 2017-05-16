//
//  VenueListViewController.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import UIKit
import CoreLocation

class VenueListViewController: UIViewController {

    
    @IBOutlet weak var listTableView: UITableView!
    let venueListIdentifire = "VenueListCell"
    var venues = [Venue]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Venues"
        listTableView.estimatedRowHeight = Dimentions.VenueListTable.rowHeight
        listTableView.tableFooterView = UIView()

        //calling method to get location
        LocationHandler.sharedInstance().delegate = self
        LocationHandler.sharedInstance().getLocation()
        ActivityView.showActivityIndicator(label: "Loading..")
    }
    
    @IBAction func refreshLocationList(_ sender: Any) {
        LocationHandler.sharedInstance().getLocation()
    }
}


extension VenueListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return venues.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: venueListIdentifire,
                                                 for: indexPath) as! VenueListCell
        let venue = venues[indexPath.row]
        let distance: Float = Float(venue.location.distance)
        var distanceString: String
        
        distanceString = distance < 1000 ? String(format: "%.0fm", distance) : String(format: "%.2fKm", distance/1000)
        cell.setTitle(title: venue.name, and: distanceString)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let venue = venues[indexPath.row]
        let venueDetail = VenueDetailViewController.loadFromNib(venue: venue)
        self.navigationController?.pushViewController(venueDetail, animated: true)
    }
}


extension VenueListViewController :LocationServiceDelegate {
    
    func locationUpdate(location: CLLocation) {
        let latLong = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
        ActivityView.showActivityIndicator(label: "Getting venue list..")
        Service.getVenues(currentLocation: latLong) { (venueList) in
            ActivityView.hideActivityIndicator()
            self.venues.removeAll()
            self.venues = venueList.sorted(by: {($0.0.location.distance) < ($0.1.location.distance)})
            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
    
    func locationServiceAreDisbaled() {
        self.showSettingAlert()
        ActivityView.hideActivityIndicator()
    }
    
    func locationServiceAreDeniedOrRestricted() {
        self.showSettingAlert()
        ActivityView.hideActivityIndicator()
    }

    
    func locationError(error: NSError) {
        ActivityView.hideActivityIndicator()
        let alert = UIAlertController(title: Message.locationErrorTitle,
                                      message: Message.locationRefresh,
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .cancel,
                                         handler: nil)
        
        alert.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alert,
                                                      animated: true,
                                                      completion: nil)
    }
    
    
    func showSettingAlert() {
        let alert = UIAlertController(title: Message.locationErrorTitle, message: Message.locationSettings, preferredStyle: .alert)
        
        let refreshAction = UIAlertAction(title: "Settings",
                                          style: .default) { action in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        alert.addAction(refreshAction)
        alert.addAction(cancelAction)
        
        if #available(iOS 9.0, *) {
            alert.preferredAction = refreshAction
        }
        self.view.window?.rootViewController?.present(alert,
                                                      animated: true,
                                                      completion: nil)
    }
}

extension VenueListViewController {
    
}

