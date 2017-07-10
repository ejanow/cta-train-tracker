//
//  StopRepo.swift
//  cta-train-tracker
//
//  Created by e on 4/27/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation

struct StopRepo {
    
    public static var stops: [Stop] = [Stop]()
    
    public static func initialize() {
        
        guard stops.count == 0 else { return; } // No need to re-initialize
        
        
        do {
            
            guard let filePath = Bundle.main.path(forResource: "stops", ofType: "csv")
                else {
                    Utils.LogError("Error getting path!")
                    return;
            }
            
            let csvData = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
            
            let cleanCsv = cleanLineBreaksInFile(csvData).components(separatedBy: "\n")
            
            guard cleanCsv.count > 0
                else {
                    Utils.LogError("cleanCSV count < 0")
                    return;
            }
            
            var first = true
            for row in cleanCsv {
                
                if first {
                    first = false
                    continue
                }
                
                let splitRow = row.components(separatedBy: ",")
                
                if let newStops = StopFactory.makeFromCsvRow(splitRow) {
                    self.stops.append(contentsOf: newStops)
                }
            }
            
            
            Utils.log(["Stop Count: " + String(stops.count)])
            
        } catch {
            Utils.LogError("Error initializing from CSV File")
            
        }
    }
    
    private static func cleanLineBreaksInFile(_ s: String) -> String {
        
        // Credit to: https://makeapppie.com/2016/05/23/reading-and-writing-text-and-csv-files-in-swift/
        var cleanFile = s
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
        
    }
    
}
