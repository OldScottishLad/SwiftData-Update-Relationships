//
//  ManyUpdateView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import SwiftData
import WidgetKit

struct ManyUpdateView: View {
    var many: Many
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var selectedOne1: One1?
    @State private var selectedOne2: One2?
    @State private var textOne1Name: String = ""
    @State private var textOne2Name: String = ""
    @State private var inputStage1: Int = 0
    @State private var inputStage2: Int = 0
    @State private var showOne1List = true
    //•For opening the picker01 list and hiding the other One01 fields
    @State private var showOne2List = true
    //•For opening the picker02 list and hiding the other One02 fields
    @State private var manyName: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                // MARK: Many Name
                if showOne1List && showOne2List {
                    Section (header: Text("Name: (Required)")) {
                        TextField(many.manyName.isEmpty ? "Enter name here…" : many.manyName,
                        text: $manyName)
                    }.textCase(nil)
                }
                //  MARK: One01 Name
                if showOne2List {
                    Section(header: Text("One1 Name:")) {
                        One1NamePicker(
                            selectedOne1: $selectedOne1,
                            textOne1Name: $textOne1Name,
                            showOne1List: $showOne1List,
                            inputStage1: $inputStage1)
                    }.textCase(nil)
                }
                //  MARK: One02 Name
                if showOne1List {
                    Section(header: Text("One2 Name:")) {
                        One2NamePicker(
                            selectedOne2: $selectedOne2,
                            textOne2Name: $textOne2Name,
                            showOne2List: $showOne2List,
                            inputStage2: $inputStage2)
                    }.textCase(nil)
                }
            }
        }
        //  MARK: •oneAppear
        .onAppear() {
            selectedOne1 = many.one1
            //  MARK: ••textOne1Name is initialized
            let name101 = selectedOne1?.one1Name
            if name101 == nil {
                //textOne1Name = "Select One1 Name"
                textOne1Name = "Unselected"
            } else {
                textOne1Name = name101!
            }
            selectedOne2 = many.one2
            //  MARK: ••textOne2Name is initialized
            let name201 = selectedOne2?.one2Name
            if name201 == nil {
                textOne2Name = "Unselected"
            } else {
                textOne2Name = name201!
            }
        }
        .navigationTitle("Update 🄼Many")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Done") {
                    updateMany()
                    WidgetCenter.shared.reloadTimelines(ofKind: "TripsWidget")
                    dismiss()
                }.disabled(!showOne1List || !showOne2List)
            }
        }
    }
    private func updateMany() {
        //  MARK: •One01 Updates✅
        if textOne1Name == selectedOne1?.one1Name {
            //  MARK: ••textOne1Name = one1Name✅
        } else {
            //  MARK: ••textOne1Name ≠ one1Name✅
            if textOne1Name == "Unselected" {
                if selectedOne1 != nil {
                    //  MARK: •••Remove one1Name✅
                    let array1 = selectedOne1!.many1
                    //Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
                    //•This has already beeen [Done]
                    let name1 = many
                    textOne1Name = selectedOne1!.one1Name
                    if let i = array1.firstIndex(of: name1) {
                        selectedOne1?.many1.remove(at: i)
                    }
                }
            } else {
                //  MARK: •••Update one1Name✅
                let newOne01 = One1(one1Name: textOne1Name, one1Rating: "")
                newOne01.many1.append(many)
            }
            //  MARK: ••Reset textOne1Name
            selectedOne1 = many.one1
            let name102 = selectedOne1?.one1Name
            if name102 == nil {
                textOne1Name = ""
            } else {
                textOne1Name = name102!
            }
        }
        //  MARK: •One02 Updates✅
        if textOne2Name == selectedOne2?.one2Name {
            //  MARK: ••textOne2Name = one2Name✅
        } else {
            //  MARK: ••textOne2Name ≠ one2Name✅
            if textOne2Name == "One2 Name Unselected" {
                //  MARK: •••Removed one2Name✅
                let array2 = selectedOne2!.many2
                let name2 = many
                textOne2Name = selectedOne2!.one2Name
                if let i = array2.firstIndex(of: name2) {
                    selectedOne2?.many2.remove(at: i)
                }
            } else {
                //  MARK: •••Update one2Name✅
                let newOne0201 = One2(one2Name: textOne2Name, one2Rating: "")
                newOne0201.many2.append(many)
            }
            //  MARK: ••Reset textOne2Name
            selectedOne2 = many.one2
            let name202 = selectedOne2?.one2Name
            if name202 == nil {
                textOne2Name = ""
            } else {
                textOne1Name = name202!
            }
        }
        try! self.modelContext.save()
    }
}
struct One1NamePicker: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var selectedOne1: One1?
    @Binding var textOne1Name: String
    @Binding var showOne1List: Bool
    @Binding var inputStage1: Int
    @Query(sort: [SortDescriptor(\One1.one1Name, comparator: .localized)])
    var one1s: [One1]
    var body: some View {
        //  MARK: •One1NamePicker
        if showOne1List {
            //  MARK: •One1 Name Button
            Button {
                self.showOne1List = false
                self.inputStage1 = 1
            } label: {
                if textOne1Name == "One1 Name Unselected" {
                    //•Not sure about "One1 Name Unselected"?
                    Text("Select One1 Name")
                } else {
                    Text(textOne1Name)
                }
            }
        } else {
            //  MARK: •One1 Name Picker List
            List(selection: $selectedOne1) {
                ForEach(one1s.sorted(by: {$0.one1Name < $1.one1Name}), id: \.self) {one1 in
                    if one1.one1Name != selectedOne1?.one1Name {
                        Button(one1.one1Name) {
                            textOne1Name = one1.one1Name
                            self.showOne1List = true
                            self.inputStage1 = 1
                        }
                    }
                }
                Button("Unselect One1 Name") {
                    textOne1Name = "Unselected"
                    self.showOne1List = true
                    self.inputStage1 = 1
                }
                Button("Close this list") {
                    self.showOne1List = true
                }
            }
        }
    }
}
struct One2NamePicker: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var selectedOne2: One2?
    @Binding var textOne2Name: String
    @Binding var showOne2List: Bool
    @Binding var inputStage2: Int
    @Query(sort: [SortDescriptor(\One2.one2Name, comparator: .localized)])
    var one2s: [One2]
    var body: some View {
        //  MARK: •One2NamePicker
        if showOne2List {
            //  MARK: •One2 Name Button
            Button {
                self.showOne2List = false
                self.inputStage2 = 1
            } label: {
                if textOne2Name == "One2 Name Unselected" {
                    Text("Unselected")
                } else {
                    Text(textOne2Name)
                }
            }
        } else {
            //  MARK: •One2 Name Picker List
            List(selection: $selectedOne2) {
                ForEach(one2s.sorted(by: {$0.one2Name < $1.one2Name}), id: \.self) {one2 in
                    if one2.one2Name != selectedOne2?.one2Name {
                        Button(one2.one2Name) {
                            textOne2Name = one2.one2Name
                            self.showOne2List = true
                            self.inputStage2 = 1
                        }
                    }
                }
                Button("Unselect One2 Name") {
                    textOne2Name = "One2 Name Unselected"
                    self.showOne2List = true
                    self.inputStage2 = 1
                }
                Button("Close this list") {
                    self.showOne2List = true
                }
            }
        }
    }
}
