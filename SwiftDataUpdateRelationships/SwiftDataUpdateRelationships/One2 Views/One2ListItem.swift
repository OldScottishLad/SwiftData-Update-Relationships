//
//  One2ListItem.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI

struct One2ListItem: View {
    var one2: One2
    var body: some View {
        NavigationLink(value: one2) {
            Text(one2.one2Name)}
    }
}
