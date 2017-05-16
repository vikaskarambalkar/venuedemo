//
//  Service.swift
//  NearBy
//
//  Created by webwerks on 5/16/17.
//  Copyright © 2017 neosoft. All rights reserved.
//

import Foundation

struct Service {
    
    static func getVenues(currentLocation: String, completion: @escaping (_ : [Venue]) -> Void)  {
        
        let searchURL = Constants.BaseServerURL + "venues/search/?v=20130815"
            + "&client_id=" + Constants.clientId
            + "&client_secret=" + Constants.clientSecret
            + "&ll=" + currentLocation
        
        let task = URLSession.shared.dataTask(with: URL(string: searchURL)!) { ( data, response, error) in
            
            guard let data = data, let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) else {
                return
            }
            
            if let apiJSON = jsonData as? [String: Any], let response = apiJSON["response"] as? [String: Any], let venues = response["venues"] as? [[String: Any]] {
                completion(venues.map({Venue(jsonData: $0)}))
            }
        }
        
        task.resume()
    }
}
