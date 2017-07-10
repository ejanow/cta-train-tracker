//
//  StopQueries.swift
//  cta-train-tracker
//
//  Created by e on 4/27/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation



struct StopQueries {
    
    public static func GetStopsByLine(_ line: Line) -> [Stop] {
        
        return StopRepo.stops.filter { $0.line == line }
        
    }
    
    public static func GetStopsByLineAndDirection(line: Line, direction: Direction) -> [Stop] {
        
        let stopsByLine = GetStopsByLine(line)
        
        return stopsByLine.filter { $0.direction.rawValue == direction.rawValue }
        
    }
    
}
