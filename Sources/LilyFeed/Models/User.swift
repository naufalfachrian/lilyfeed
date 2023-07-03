//
//  User.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Fluent
import Vapor


public protocol User: Authenticatable {
    
    var username: String { get }
    
}


// MARK: - User Model

public final class UserModel: User, Model, Content {
    
    public static var schema: String = "users"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "username")
    public var username: String
    
    @Field(key: "password")
    var password: String
    
    public init() { }
    
    public init(
        username: String,
        password: String
    ) throws {
        self.username = username
        self.password = try Bcrypt.hash(password)
    }
    
}
