//
//  String.swift
//  
//
//  Created by Kevin Waltz on 30.06.22.
//

import Foundation

extension String {
    func setFormat() -> Date? {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: self)
    }
}
