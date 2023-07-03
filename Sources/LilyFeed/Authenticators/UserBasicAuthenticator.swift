//
//  UserBasicAuthenticator.swift
//  
//
//  Created by Bunga Mungil on 21/06/23.
//

import Vapor


public struct UserBasicAuthenticator: AsyncBasicAuthenticator {
    
    typealias User = LilyFeed.User
    
    public func authenticate(basic: BasicAuthorization, for request: Request) async throws {
        if let user = try await (
            UserModel
                .query(on: request.db)
                .filter(\.$username, .equal, basic.username)
                .first()
        ), try Bcrypt.verify(basic.password, created: user.password) {
            request.auth.login(user)
        }
    }
    
}
