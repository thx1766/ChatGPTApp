//
//  HistoryView.swift
//  ChatGPTApp
//
//  Created by Nate Schaffner on 3/28/24.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject private var model: Model
    @Environment(\.dismiss) private var dismiss
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: true)])
    private var historyItemResults: FetchedResults<HistoryItem>
    
    var body: some View {
        List(historyItemResults) { historyItem in
            Text(historyItem.question ?? "")
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    model.query = Query(question: historyItem.question ?? "", answer: historyItem.answer ?? "")
                    #if os(iOS)
                    dismiss()
                    #endif
                }
        }
    }
}

#Preview {
    HistoryView().environmentObject(Model())
}
