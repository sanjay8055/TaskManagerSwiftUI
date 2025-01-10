//
//  Item.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 10/01/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var date: Date
    var title: String
    var icon: String
    var priority: Priority
    
    init(date: Date, title: String, icon: String, priority: Priority = .normal) {
        self.date = date
        self.title = title
        self.icon = icon
        self.priority = priority
    }
}

enum Priority: Int, Codable {
    case normal = 0
    case low
    case high
}
