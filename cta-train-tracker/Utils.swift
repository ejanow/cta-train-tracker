//
//  Utils.swift
//  cta-train-tracker
//
//  Created by e on 4/29/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import Foundation

struct Utils {
    
    public static func initializeApp() {
        
        DispatchQueue.global(qos: .background).async {
            StopRepo.initialize()
        }
    }
    
    public static func LogError(_ msg: Any) {
        LogError([msg])
    }
    
    public static func LogError(_ errors: [Any]) {
        
        log("------------------ERROR------------------")
        
        for e in errors {
            self.log(e)
        }
        
        log("-----------------------------------------")
        
    }
    
    public static func log(_ items: [Any]) {
        
        log("------------------DEBUG------------------")
        
        for i in items {
            log(i)
        }
        
        log("-----------------------------------------")
        
        
    }
    
    private static func log(_ x: Any) {
        
        print(x) // write this to file? Sned to PagerDuty? Etc etc.      
    }
    
    public static func boolFromStringInt(_ s: String) -> Bool {
        if let i = Int(s) {
            return i != 0
        }
        return false
    }
    
    public static func minutesFromNow(_ d: Date) -> Int {
        
        let cal = Calendar.current
        
        let timeNow = cal.dateComponents([.hour, .minute], from: Date())
        let timeThen = cal.dateComponents([.hour, .minute], from: d)
        
        guard
            let nowHour = timeNow.hour,
            let nowMinute = timeNow.minute,
            let thenHour = timeThen.hour,
            let thenMinute = timeThen.minute
            else {
                return 0
        }
        
        let diff = thenHour - nowHour
        
        return diff * 60 + thenMinute - nowMinute
    }
    
    public static func getBoolFromString(_ s: String) -> Bool {
        return s.trimmingCharacters(in: .whitespaces).lowercased() == "true" // I want to return false in case of ambiguity here
    }
}
