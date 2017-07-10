//
//  Stop.swift
//  cta-train-tracker
//
//  Created by e on 4/27/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation

struct Stop {
    
    let stopId: Int
    let direction: Direction
    let stopName: String
    let stationName: String
    let StationNameDesc: String
    let mapId: Int
    let ada: Bool
    let location: String
    let directionType: DirectionType
    let line: Line
}
