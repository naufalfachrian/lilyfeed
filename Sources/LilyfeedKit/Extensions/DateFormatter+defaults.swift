//
//  DateFormatter+defaults.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


extension DateFormatter {
    
    static let display: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        return formatter
    }()
    
    static let ISO8601_1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    static let ISO8601_2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        return formatter
    }()
    
}
