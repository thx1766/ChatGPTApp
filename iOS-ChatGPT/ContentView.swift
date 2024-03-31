//
//  ContentView.swift
//  iOS-ChatGPT
//
//  Created by Nate Schaffner on 3/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationStack {
            MainView()
                .sheet(isPresented: $isPresented, content: {
                    NavigationStack {
                        HistoryView()
                            .navigationTitle("History")
                    }
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isPresented = true
                        } label: {
                            Text("Show History")
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        .environmentObject(Model())
    
}
