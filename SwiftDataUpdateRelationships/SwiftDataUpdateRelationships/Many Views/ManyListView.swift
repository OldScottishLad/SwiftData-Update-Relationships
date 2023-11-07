//
//  ManyListView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import SwiftData
import WidgetKit

struct ManyListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Many.manyName, order: .forward)
    var one1s: [Many]
    @State private var showAddOne = false//finish this later
    @State private var selection: Many?
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(one1s.sorted(by: {$0.manyName < $1.manyName})) {many in
                    ManyListItem(many: many)
                }
            }
            .navigationTitle("🄼Manys")
        } detail: {
            if let selection = selection {
                NavigationStack {
                    ManyDetailView(many: selection)
                }
            }
        }
    }
}
