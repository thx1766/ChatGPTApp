//
//  ContentView.swift
//  macOS-ChatGPT
//
//  Created by Nate Schaffner on 3/26/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            HistoryView()
        } detail: {
            MainView()
        }
    }
}

#Preview {
    ContentView()
}
