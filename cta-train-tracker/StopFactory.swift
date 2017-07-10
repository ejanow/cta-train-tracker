//
//  StopFactory.swift
//  cta-train-tracker
//
//  Created by e on 4/28/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation


struct StopFactory {
    
    static private var rowNum = 1
    
    public static func makeFromCsvRow(_ row: [String]) -> [Stop]? {
        var res = [Stop]()
        
        guard row.count > 0 && row.first != "" else { return nil }
        
        rowNum += 1
        let cleanRow = row.map { cleanString($0) }
        
        let str = cleanRow[2].lowercased()
        let index = str.index(str.startIndex, offsetBy: 7)
        if str.substring(to: index)  == "\"howard" { Utils.LogError([str, rowNum]) }
        
        
        guard let stopId = Int(cleanRow[0])
            else {
                Utils.LogError(["Error parsing stop ID", "rownum \(rowNum)", cleanRow])
                print(rowNum)
                print (cleanRow[0])
                return nil
        }
        let direction = self.getDirection(cleanRow[1])
        let directionType = self.getDirectionType(cleanRow[1])
        let stopName = cleanRow[2]
        let stationName = cleanRow[3]
        let stationDescrptiveName = cleanRow[4]
        guard let mapId = Int(cleanRow[5])
            else {
                Utils.LogError(["Error Parsing MapID \(rowNum)", cleanRow[5]])
                return nil
        }
        let ADA = Utils.getBoolFromString(cleanRow[6])
        
        let location = (cleanRow[16] + "," + cleanRow[17]).replacingOccurrences(of: "\"", with: "")
        
        
        let lines = self.getLinesFromRow(cleanRow)
        
        for line: Line in lines {
            
            let newStop: Stop = Stop(stopId: stopId, direction: direction,
                                     stopName: stopName, stationName: stationName,
                                     StationNameDesc: stationDescrptiveName,
                                     mapId: mapId, ada: ADA, location: location,
                                     directionType: directionType, line: line)
            
            res.append(newStop)
        }
        
        return res
    }
    
    
    private static func getDirectionType(_ directionId: String) -> DirectionType {
        
        switch cleanString(directionId).lowercased() {
        case "w", "e":
            return DirectionType.EastWest
        default:
            return DirectionType.NorthSouth
        }
    }
    
    private static func getDirection(_ directionId: String) -> Direction {
        
        switch cleanString(directionId).lowercased() {
        case "w":
            return Direction.west
        case "e":
            return Direction.east
        case "n":
            return Direction.north
        default:
            return Direction.south
        }
    }
    
    private static func getLinesFromRow(_ row: [String]) -> [Line] {
        var lines = [Line]()
        
        for i in 7...15 {
            
            guard i != 12 else { continue; } // Don't care about Purple Express
            
            if (cleanString(row[i]).lowercased() == "true") {
                if let newLine = getLineByRowIndex(i) {
                    lines.append(newLine)
                }
            }
            
        }
        
        return lines
    }
    
    private static func cleanString(_ s: String) -> String {
        return s.trimmingCharacters(in: .whitespaces)
    }
    
    private static func getLineByRowIndex(_ i: Int) -> Line? {
    
        switch i {
        case 7:
            return Line.red
        case 8:
            return Line.blue
        case 9:
            return Line.green
        case 10:
            return Line.brown
        case 11:
            return Line.purple
        case 13:
            return Line.yellow
        case 14:
            return Line.pink
        case 15:
            return Line.orange
        default:
            return nil
        }
    }
}
