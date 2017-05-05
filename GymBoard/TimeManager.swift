//
//  TimeManager.swift
//  GymBoard
//
//  Created by João Luís on 11/04/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import Foundation

class TimeManager {
    
    static func getTodaysDate() -> String {
        let date = Date()
        return TimeManager.convertDateToAppFormate(date: date)
    }
    
    
    /// YYYY-MM-DD
    ///
    /// - Parameter date: <#date description#>
    /// - Returns: <#return value description#>
    static func convertDateToAppFormate(date: Date) -> String {
        let calendar = Calendar.current
        let dayC = calendar.component(.day, from: date)
        let mouthC = calendar.component(.month, from: date)
        let yearC = calendar.component(.year, from: date)
        
        let day = (dayC > 9 ? "\(dayC)" : "0\(dayC)")
        let mouth = (mouthC > 9 ? "\(mouthC)" : "0\(mouthC)")
        return "\(yearC)-\(mouth)-\(day)"
    }
}
