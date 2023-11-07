//
//  One1DetailView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI

struct One1DetailView: View {
    @Bindable var one1: One1
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                //  MARK: Detail View
                Section("Details:") {
                        Text("Name: \(one1.one1Name)")
                        Text("Rating: \(one1.one1Rating)")
                    NavigationLink {
                        One1UpdateView(one1: one1)
                    } label: {
                        HStack {
                            Text("Change")
                                .foregroundColor(.gray)
                            Text(one1.one1Name)
                                .bold()
                            Text("Details")
                                .foregroundColor(.gray)
                        }
                    }
                }.textCase(nil)
                //  MARK: List View
                Section(header: Text("🄼Many List:")) {
                    ForEach(one1.many1.sorted(by: {$0.manyName < $1.manyName}), id: \.self) {many in
                        NavigationLink(destination: ManyDetailView(
                            many: many)) {
                                Text(many.manyName)
                            }
                    }
                }.textCase(nil)
            }
        }
        .navigationTitle("①One")
    }
}
