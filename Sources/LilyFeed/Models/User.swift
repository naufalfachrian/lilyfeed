//
//  User.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Fluent
import Vapor


protocol User: Authenticatable {
    
    var username: String { get }
    
}


// MARK: - User Model

final class UserModel: User, Model, Content {
    
    static var schema: String = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    init() { }
    
    init(
        username: String,
        password: String
    ) throws {
        self.username = username
        self.password = try Bcrypt.hash(password)
    }
    
}
