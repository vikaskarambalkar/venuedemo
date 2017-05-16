//
//  Location.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import Foundation
import CoreLocation

@objc protocol LocationServiceDelegate {
    func locationUpdate(location: CLLocation)
    func locationError(error: NSError)
    
    @objc optional func locationServiceAreDisbaled()
    @objc optional func locationServiceAreDeniedOrRestricted()
}

class LocationHandler: NSObject {

    static var instance: LocationHandler!
    weak var delegate: LocationServiceDelegate?
    fileprivate var locationManager: CLLocationManager = CLLocationManager()
    fileprivate var currentLocation: CLLocation?
    
    static func sharedInstance() -> LocationHandler {
        instance = (instance ?? LocationHandler())
        return instance
    }
    

    func getLocation() {
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == .restricted || authorizationStatus == .denied {
            
            delegate?.locationServiceAreDeniedOrRestricted?()
        
        } else if !CLLocationManager.locationServicesEnabled() {
            
            delegate?.locationServiceAreDisbaled?()
        
        } else {
            
            let selector = #selector(locationManager.requestWhenInUseAuthorization)
            if locationManager.responds(to:selector) {
                
                if authorizationStatus == .authorizedAlways
                    || authorizationStatus == .authorizedWhenInUse {
                    
                    locationManager.startUpdatingLocation()
                } else {
                    
                    locationManager.requestWhenInUseAuthorization()
                }
                
            } else {
                locationManager.startUpdatingLocation()
            }
        }
    }
}

extension  LocationHandler: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .restricted:
            delegate?.locationServiceAreDeniedOrRestricted?()
            break
        case .denied:
            delegate?.locationServiceAreDeniedOrRestricted?()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            
            let newLocation: CLLocation = locations.last!
            let locationAge: TimeInterval = -newLocation.timestamp.timeIntervalSinceNow
            if locationAge > 5.0 {
                return;
            }
            locationManager.stopUpdatingLocation()
            currentLocation = newLocation
            delegate?.locationUpdate(location: newLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        if (delegate != nil) {
            delegate?.locationError(error: error as NSError)
        }
    }
    
}

