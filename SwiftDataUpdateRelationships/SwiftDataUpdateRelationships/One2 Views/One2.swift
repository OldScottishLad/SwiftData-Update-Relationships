//
//  One2.swift
//  SwiftDataUpdateRelationships
//

import SwiftData

@Model
class One2 {
    @Attribute(.unique) var one2Name: String
    var one2Rating: String
    var many2: [Many] = [Many]()
    init(one2Name: String, one2Rating: String) {
        self.one2Name = one2Name
        self.one2Rating = one2Rating
    }
}
