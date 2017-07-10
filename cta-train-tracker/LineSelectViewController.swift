//
//  LineSelectViewController.swift
//  cta-train-tracker
//
//  Created by e on 4/28/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit

class LineSelectViewController: UIViewController {
    
    var selectedLine: Line?
    
    @IBAction func stopSelected(_ sender: UIButton) {
        
        let lineText = sender.titleLabel?.text        
        
        if let l = Line(rawValue: lineText ?? "") {
            
            selectedLine = l
            
            performSegue(withIdentifier: "toStopSelect", sender: nil)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? StopSelectTableViewController {
            
            guard let sL: Line = selectedLine else { return }
            
            let newStops = StopQueries.GetStopsByLine(sL).sorted { $0.stopName < $1.stopName }
            
            destination.stops = newStops
        }
    }
}
