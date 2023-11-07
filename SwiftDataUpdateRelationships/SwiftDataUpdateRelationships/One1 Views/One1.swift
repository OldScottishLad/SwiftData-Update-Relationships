//
//  One1.swift
//  SwiftDataUpdateRelationships
//

import SwiftData

@Model
class One1 {
    @Attribute(.unique) var one1Name: String
    var one1Rating: String
    var many1: [Many] = [Many]()
    init(one1Name: String, one1Rating: String) {
        self.one1Name = one1Name
        self.one1Rating = one1Rating
    }
}
