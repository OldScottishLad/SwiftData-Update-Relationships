//
//  One1UpdateView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import WidgetKit

struct One1UpdateView: View {
    var one1: One1
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var one1Name: String = ""
    @State private var one1Rating: String = ""
    @State private var one1RatingArray: [String] = ["High", "Medium", "Low"]
    var body: some View {
        Form {
            // MARK: •one1Name
            Section (header: Text("Name: (Required)")) {
                TextField(one1.one1Name.isEmpty ? "Enter name here…" : one1.one1Name,
                text: $one1Name)
            }.textCase(nil)
            Section (header: Text("Rating:")) {
                // MARK: •one1Rating
                VStack {
                    Picker("Box Lifting Hight", selection: $one1Rating) {
                        ForEach(one1RatingArray, id: \.self) {rating in
                            Text(rating)
                        }
                    }
                }
                .pickerStyle(.segmented)
            }.textCase(nil)
        }
        .onAppear() {
            one1Name = one1.one1Name
            one1Rating = one1.one1Rating
        }
        .navigationTitle("Update ①One")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    updateOne1()
                    WidgetCenter.shared.reloadTimelines(ofKind: "TripsWidget")
                    dismiss()
                }
                .disabled(one1Name == "" || one1Rating.isEmpty)
            }
        }
    }
    private func updateOne1() {
        one1.one1Name = one1Name
        one1.one1Rating = one1Rating
        try! self.modelContext.save()
    }
}
