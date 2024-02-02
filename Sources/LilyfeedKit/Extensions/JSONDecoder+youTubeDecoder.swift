//
//  JSONDecoder+youTubeDecoder.swift
//
//
//  Created by Bunga Mungil on 02/02/24.
//

import Foundation


extension JSONDecoder {
    
    static let youTubeDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let raw = try decoder.singleValueContainer().decode(String.self)
            if let try1 = DateFormatter.ISO8601_1.date(from: raw) {
                return try1
            }
            if let try2 = DateFormatter.ISO8601_2.date(from: raw) {
                return try2
            }
            return Date(timeIntervalSince1970: 0)
        }
        return decoder
    }()
    
}
