//
//  ArrivalFactory.swift
//  cta-train-tracker
//
//  Created by e on 4/29/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ArrivalFactory {
    
    public static func makeFrom(json: JSON) -> [Arrival] {
        
        var arrivals = [Arrival]()
        
        
        for j in json.arrayValue {
            let newArrival = self.makeFromJsonArrayObject(j)
            if let a = newArrival {
                arrivals.append(a)
            }
        }
        
        
        return arrivals
    }
    
    private static func makeFromJsonArrayObject(_ j: JSON) -> Arrival? {
        
        guard let stopIdString = j["stpId"].string, let stopId = Int(stopIdString) else {
            Utils.LogError(["Error Getting stpidID", j])
            return nil
        }
        
        guard let stationIdString = j["staId"].string, let stationId = Int(stationIdString) else {
            Utils.LogError(["Error parsing staID", j])
            return nil
        }
        
        guard let stopDesciption = j["stpDe"].string else {
            Utils.LogError(["Error parsing stpDe", j])
            return nil
        }
        
        guard let isSch = j["isSch"].string else {
            Utils.LogError(["Error parsing isSch", j])
            return nil
        }
        let isScheduled = Utils.boolFromStringInt(isSch)
        
        
        guard let d = j["prdt"].string, let predictedDate = getDateFromApiString(d) else {
            Utils.LogError(["Error parsing prdt", j])
            return nil
        }
        
        guard let isDly = j["isDly"].string else {
            Utils.LogError(["Error parsing isDly", j])
            return nil
        }
        let isDelayed = Utils.boolFromStringInt(isDly)
        
        guard let isApp = j["isApp"].string else {
            Utils.LogError(["Error parsing isApp", j])
            return nil
        }
        let isApproaching = Utils.boolFromStringInt(isApp)
        
        guard let dt = j["arrT"].string, let arrivalTime = getDateFromApiString(dt) else {
            Utils.LogError(["Error parsing arrT", j])
            return nil
        }
        
        guard let run = j["rn"].string else {
            Utils.LogError(["Error parsing rn", j])
            return nil
        }
        
        return Arrival(stopId: stopId, stationId: stationId, stopDescription: stopDesciption,
                       isScheduled: isScheduled, isApproaching: isApproaching,
                       isDelayed: isDelayed, predicted: predictedDate,
                       arriving: arrivalTime, run: run)
    }
    
    private static func getDateFromApiString(_ s: String) -> Date? {
        
        var comp = DateComponents()
        
        let splitDateString = s.components(separatedBy: "T")
        let d = splitDateString[0]
        let t = splitDateString[1]
        
        let dSplit = d.components(separatedBy: "-")
        let year = Int(dSplit[0])
        let month = Int(dSplit[1])
        let day = Int(dSplit[2])
        
        let tSplit = t.components(separatedBy: ":")
        let hour = Int(tSplit[0])
        let minute = Int(tSplit[1])
        let second = Int(tSplit[2])
        
        comp.year = year
        comp.month = month
        comp.day = day
        comp.hour = hour
        comp.minute = minute
        comp.second = second
        
        return Calendar.current.date(from: comp)
    }
}
