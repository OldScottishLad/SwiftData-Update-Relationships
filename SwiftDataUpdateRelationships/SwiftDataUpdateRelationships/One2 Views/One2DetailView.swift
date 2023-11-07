//
//  One2DetailView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI

struct One2DetailView: View {
    @Bindable var one2: One2
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                //  MARK: Detail View
                Section("Details:") {
                        Text("Name: \(one2.one2Name)")
                        Text("Rating: \(one2.one2Rating)")
                    NavigationLink {
                        One2UpdateView(one2: one2)
                    } label: {
                        HStack {
                            Text("Change")
                                .foregroundColor(.gray)
                            Text(one2.one2Name)
                                .bold()
                            Text("Details")
                                .foregroundColor(.gray)
                        }
                    }
                }.textCase(nil)
                //  MARK: List View
                Section(header: Text("🄼Many List:")) {
                    ForEach(one2.many2.sorted(by: {$0.manyName < $1.manyName}), id: \.self) {many in
                        NavigationLink(destination: ManyDetailView(
                            many: many)) {
                                Text(many.manyName)
                            }
                    }
                }.textCase(nil)
            }
        }
        .navigationTitle("②One")
    }
}
