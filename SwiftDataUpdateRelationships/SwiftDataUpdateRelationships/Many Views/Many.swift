//
//  Many.swift
//  SwiftDataUpdateRelationships
//

import SwiftData

@Model
class Many {
    @Attribute(.unique) var manyName: String
    var one1: One1?
    var one2: One2?
    init(manyName: String) {
        self.manyName = manyName
    }
}
