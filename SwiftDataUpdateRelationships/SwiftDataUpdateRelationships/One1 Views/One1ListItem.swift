//
//  One1ListItem.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI

struct One1ListItem: View {
    var one1: One1
    var body: some View {
        NavigationLink(value: one1) {
            Text(one1.one1Name)}
    }
}
