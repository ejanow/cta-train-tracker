//
//  StopSelectTableViewController.swift
//  cta-train-tracker
//
//  Created by e on 4/28/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class StopSelectTableViewController: UITableViewController {
    
    public var stops: [Stop]?
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count: Int = stops?.count
            else {
                return 0
        }
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
        
        let stop = stops![indexPath.row]
        let title = stop.stopName
        
        cell.textLabel?.text = title

        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? ArrivalsTableViewController {
            
            guard
                let idx = self.tableView.indexPathForSelectedRow?.row,
                let selectedStop = stops?[idx]
                else { return; }
        
            destination.stop = selectedStop
        }
    }
    
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        performSegue(withIdentifier: "toArrival", sender: nil)
    }
}
