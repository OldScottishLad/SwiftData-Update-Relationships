//
//  One1ListView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import SwiftData
import WidgetKit

struct One1ListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \One1.one1Name, order: .forward)
    var one1s: [One1]
    @State private var selection: One1?
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(one1s.sorted(by: {$0.one1Name < $1.one1Name})) {one1 in
                    One1ListItem(one1: one1)
                }
            }
            .navigationTitle("①Ones")
            .overlay {
                if one1s.isEmpty {
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
                    One1DetailView(one1: selection)
                }
            }
        }
    }
}
struct LoadData: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Load the One and Many Test Data") {
            addData()
        }
    }
    func addData() {
        let newOne11 = One1(one1Name: "One11", one1Rating: "Low")
        self.modelContext.insert(newOne11)
        let newOne12 = One1(one1Name: "One12", one1Rating: "High")
        self.modelContext.insert(newOne12)
        let newOne13 = One1(one1Name: "One13", one1Rating: "Medium")
        self.modelContext.insert(newOne13)
        let newOne21 = One2(one2Name: "One21", one2Rating: "High")
        self.modelContext.insert(newOne21)
        let newOne22 = One2(one2Name: "One22", one2Rating: "High")
        self.modelContext.insert(newOne22)
        let newOne23 = One2(one2Name: "One23", one2Rating: "Low")
        self.modelContext.insert(newOne23)
        let newMany1121 = Many(manyName: "Many1121")
        newOne11.many1.append(newMany1121)
        newOne21.many2.append(newMany1121)
        let newMany1122 = Many(manyName: "Many1122")
        newOne11.many1.append(newMany1122)
        newOne22.many2.append(newMany1122)
        let newMany1123 = Many(manyName: "Many1123")
        newOne11.many1.append(newMany1123)
        newOne23.many2.append(newMany1123)
        let newMany1221 = Many(manyName: "Many1221")
        newOne12.many1.append(newMany1221)
        newOne21.many2.append(newMany1221)
        let newMany1222 = Many(manyName: "Many1222")
        newOne12.many1.append(newMany1222)
        newOne22.many2.append(newMany1222)
        let newMany1223 = Many(manyName: "Many1223")
        newOne12.many1.append(newMany1223)
        newOne23.many2.append(newMany1223)
        let newMany1321 = Many(manyName: "Many1321")
        newOne13.many1.append(newMany1321)
        newOne21.many2.append(newMany1321)
        let newMany1322 = Many(manyName: "Many1322")
        newOne13.many1.append(newMany1322)
        newOne22.many2.append(newMany1322)
        let newMany1323 = Many(manyName: "Many1323")
        newOne13.many1.append(newMany1323)
        newOne23.many2.append(newMany1323)

        try! self.modelContext.save()
        dismiss()
    }
}
