//
//  One2ListView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import SwiftData
import WidgetKit

struct One2ListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \One2.one2Name, order: .forward)
    var one2s: [One2]
    @State private var showAddOne = false//finish this later
    @State private var selection: One2?
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(one2s.sorted(by: {$0.one2Name < $1.one2Name})) {one2 in
                    One2ListItem(one2: one2)
                }
            }
            .navigationTitle("②Ones")
            .overlay {
                if one2s.isEmpty {
                    ContentUnavailableView {
                        HStack {
                            Label("No Ones |", systemImage: "o.square.fill")
                            Label("No Manys", systemImage: "m.square.fill")
                        }
                    } description: {
                        Text("")
                        Image("discription")
                        Text("")
                        LoadData()
                   }
                }
            }
        } detail: {
            if let selection = selection {
                NavigationStack {
                    One2DetailView(one2: selection)
                }
            }
        }
    }
}
