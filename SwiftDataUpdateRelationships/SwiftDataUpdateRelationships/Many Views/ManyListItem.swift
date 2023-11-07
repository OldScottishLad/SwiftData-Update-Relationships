//
//  ManyListItem.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI

struct ManyListItem: View {
    var many: Many
    var body: some View {
        NavigationLink(value: many) {
            Text(many.manyName)
        }
    }
}
