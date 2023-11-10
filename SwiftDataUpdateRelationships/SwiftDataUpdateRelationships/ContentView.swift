//
//  ContentView.swift
//  SwiftDataUpdateRelationships
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            //•1st View - Ones
            VStack {
                One1ListView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "1.circle.fill")
                        .resizable()
                        .scaledToFit()
                    Text("①Ones")
                }
            }
            
            //•2nd View
            VStack {
                ManyListView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "m.square.fill")
                        .resizable()
                        .scaledToFit()
                    Text("Manys")
                }
            }
            
            //•3rd View - Ones
            VStack {
                One2ListView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "2.circle.fill")
                        .resizable()
                        .scaledToFit()
                    Text("②Ones")
                        .font(.caption)
                }
            }

        }
    }
}
