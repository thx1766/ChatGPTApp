//
//  iOS_ChatGPTApp.swift
//  iOS-ChatGPT
//
//  Created by Nate Schaffner on 3/26/24.
//

import SwiftUI

@main
struct iOS_ChatGPTApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
                
        }
    }
}
