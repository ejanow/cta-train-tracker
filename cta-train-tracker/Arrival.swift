//
//  Arrival.swift
//  cta-train-tracker
//
//  Created by e on 4/29/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation


struct Arrival {
    
    let stopId: Int
    let stationId: Int
    let stopDescription: String
    let isScheduled: Bool
    let isApproaching: Bool
    let isDelayed: Bool
    let predicted: Date
    let arriving: Date
    let run: String
    
    
    public func arrivalString() -> String {
        
        let mins = Utils.minutesFromNow(arriving)
        
        return "\(mins) Minutes" +
            (isApproaching ? " - Approaching Now" : "") +
            (isDelayed ? " - Delayed" : "")
    }
    
    public func getRunNumber() -> String {
        return "Run Number: \(self.run)"
    }
}
