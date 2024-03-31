//
//  String+Extensions.swift
//  ChatGPTApp
//
//  Created by Nate Schaffner on 3/26/24.
//

import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
