//
//  Date.swift
//  
//
//  Created by Kevin Waltz on 30.06.22.
//

import Foundation

extension Date {
    func setFormat() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.string(from: self)
    }
}
