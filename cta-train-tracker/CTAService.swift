//
//  CTAService.swift
//  cta-train-tracker
//
//  Created by e on 4/27/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation
import SwiftyJSON


struct CTAService {
    
    private static let k: String = Secret.API_KEY
    
    public static func getArrivals(by stop: Stop, for c: ArrivalsTableViewController) {
        
        do {
            let urlString = "http://lapi.transitchicago.com/api/1.0/ttarrivals.aspx\(k)&stpid=\(String(stop.stopId))"
            guard let url = URL(string: urlString)
                else {
                    Utils.LogError("Error building URL")
                    return
            }
        
        
            try makeHttpRequestForArrivals(url: url, for: c)
        
        } catch {
            Utils.LogError("Error making HTTP Request in CTA Service")
        }
    }
    
    private static func makeHttpRequestForArrivals(url: URL, for c: ArrivalsTableViewController) throws {
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            
            guard error == nil
                else {
                    Utils.LogError(error!.localizedDescription)
                    return
            }
            
            guard let data = data
                else {
                    Utils.LogError("Data was nil in makeHTTPReqForArr")
                    return
            }
            
            let json = JSON(data: data)
            
            let arrivalResponse: JSON = json["ctatt"]["eta"]
            
            let arrivals = ArrivalFactory.makeFrom(json: arrivalResponse)
            
            Utils.log(arrivals.map { $0.arrivalString() })
            
            DispatchQueue.main.async { // In case this function is called by the refresh thread
                
                c.arrivals = arrivals
                c.tableView.reloadData()
            }
            
        }.resume()
    }
}
