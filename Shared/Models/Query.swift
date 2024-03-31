//
//  Query.swift
//  ChatGPTApp
//
//  Created by Nate Schaffner on 3/28/24.
//

import Foundation

struct Query: Identifiable, Hashable {
    let id = UUID()
    let question: String
    let answer: String
}
