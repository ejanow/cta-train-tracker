//
//  ArrivalsTableViewController.swift
//  cta-train-tracker
//
//  Created by e on 4/29/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class ArrivalsTableViewController: UITableViewController {
    
    var stop: Stop?
    var arrivals: [Arrival]?
    var refreshing = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if let s = self.stop { CTAService.getArrivals(by: s, for: self) } // alternative without threading
        
        self.refreshArrivals() // I'm not sure if this function is safe yet
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let a = arrivals {
            return a.count
        }
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let arrival = arrivals?[indexPath.row]
        
        let id = arrival?.isApproaching ?? false ? "urgent" : "basic"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)
        
        let title = arrival?.arrivalString()
        let subtitle = arrival?.getRunNumber()
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = subtitle

        return cell
    }
    
    public func refreshArrivals() {
        
        DispatchQueue.global(qos: .background).async {
        
            while self.refreshing {
                
                if let s = self.stop {
                    CTAService.getArrivals(by: s, for: self)
                    Utils.log(["Arrivals Refreshed for \(s.stopName)"])
                }
                
                sleep(45)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // I'm not sure this is the best solution
        // My fear is that the refreshArrivals() thread will 
        // cause this view controller never be collected by the GC
        
        self.refreshing = false
    }
    
}
