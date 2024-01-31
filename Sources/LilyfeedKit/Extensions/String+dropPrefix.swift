//
//  String+dropPrefix.swift
//
//
//  Created by Bunga Mungil on 31/01/24.
//

import Foundation


extension String {
    
    func dropPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
    
}
