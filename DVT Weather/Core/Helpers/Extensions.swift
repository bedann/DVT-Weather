//
//  Extensions.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Double {
    
    var date: Date {
        Date(timeIntervalSince1970: self)
    }
    
    var celcius: Double {
        self - 273.15
    }
    
}


extension Date {
    
    func toWeekDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    func toTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
    
}
