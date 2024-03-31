//
//  macOS_ChatGPTApp.swift
//  macOS-ChatGPT
//
//  Created by Nate Schaffner on 3/26/24.
//

import SwiftUI

@main
struct macOS_ChatGPTApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Model())
                .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let contentView = ContentView().environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext).environmentObject(Model())
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let statusButton = statusItem.button {
            statusButton.image = NSImage(systemSymbolName: "brain", accessibilityDescription: "Brain")
            statusButton.action = #selector(togglePopover)
        }
            
            self.popover = NSPopover()
            self.popover.contentSize = NSSize(width: 600, height: 600)
            self.popover.behavior = .transient
        self.popover.contentViewController = NSHostingController(rootView: contentView)
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
   
}
