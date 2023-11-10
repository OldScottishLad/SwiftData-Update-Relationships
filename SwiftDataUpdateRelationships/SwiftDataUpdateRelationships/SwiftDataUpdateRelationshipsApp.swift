//
//  SwiftDataUpdateRelationshipsApp.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import SwiftData

@main
struct SwiftDataUpdateRelationshipsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [One1.self, Many.self])
        }
    }
}
