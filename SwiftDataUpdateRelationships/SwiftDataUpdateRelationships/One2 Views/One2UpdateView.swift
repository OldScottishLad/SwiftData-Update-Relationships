//
//  One2UpdateView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import WidgetKit

struct One2UpdateView: View {
    var one2: One2
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var one2Name: String = ""
    @State private var one2Rating: String = ""
    @State private var one2RatingArray: [String] = ["High", "Medium", "Low"]
    var body: some View {
        Form {
            // MARK: •one1Name
            Section (header: Text("Name: (Required)")) {
                TextField(one2.one2Name.isEmpty ? "Enter name here…" : one2.one2Name,
                text: $one2Name)
            }.textCase(nil)
            Section (header: Text("Rating:")) {
                // MARK: •one1Rating
                VStack {
                    Picker("Box Lifting Hight", selection: $one2Rating) {
                        ForEach(one2RatingArray, id: \.self) {rating in
                            Text(rating)
                        }
                    }
                }
                .pickerStyle(.segmented)
            }.textCase(nil)
        }
        .onAppear() {
            one2Name = one2.one2Name
            one2Rating = one2.one2Rating
        }
        .navigationTitle("Update ②One")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    updateOne2()
                    WidgetCenter.shared.reloadTimelines(ofKind: "TripsWidget")
                    dismiss()
                }
                .disabled(one2Name == "" || one2Rating.isEmpty)
            }
        }
    }
    private func updateOne2() {
        one2.one2Name = one2Name
        one2.one2Rating = one2Rating
        try! self.modelContext.save()
    }
}
