//
//  ManyDetailView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI

struct ManyDetailView: View {
    @Bindable var many: Many
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                //  MARK: Detail View
                Section(header: Text("Details:")) {
                    Text("Name: \(many.manyName)")
                    //  MARK: Related Ones
                    let one1Name = many.one1?.one1Name
                    if (one1Name == nil) {
                        HStack {
                            Text("①One:")
                            Text("Unselected")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("①One: \(one1Name!)")
                    }
                    let one2Name = many.one2?.one2Name
                    if (one2Name == nil) {
                        HStack {
                            Text("②One:")
                            Text("Unselected")
                                .foregroundColor(.gray)
                        }
                    } else {
                        Text("②One: \(one2Name!)")
                    }
                    //  MARK: Navigation to Update View
                    NavigationLink {
                        ManyUpdateView(many: many)
                    } label: {
                        HStack {
                            Text("Change")
                                .foregroundColor(.gray)
                            Text(many.manyName)
                                .bold()
                            Text("Details")
                                .foregroundColor(.gray)
                        }
                    }
                }.textCase(nil)
            }
        }
        .navigationTitle("🄼Many")
    }
}
