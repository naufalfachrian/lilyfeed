//
//  PayloadModel.swift
//  
//
//  Created by Bunga Mungil on 20/06/23.
//

import Fluent
import Vapor


final class PayloadModel: Model, Content {
    
    static let schema: String = "payloads"
    
    @ID(key: .id)
    public var id: UUID?
    
    @Field(key: "callback")
    public var callback: String
    
    @Field(key: "content")
    public var content: String
    
    @Field(key: "created_at")
    public var createdAt: Date
    
    init() {
        self.createdAt = Date()
    }
    
    convenience init(
        callback: String,
        content: String
    ) {
        self.init()
        self.callback = callback
        self.content = content
    }
    
}
