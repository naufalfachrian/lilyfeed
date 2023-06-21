//
//  User.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Vapor


protocol User: Authenticatable {
    
    var username: String { get }
    
}
