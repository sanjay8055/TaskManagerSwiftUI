//
//  Item.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 10/01/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Item: Identifiable {
    var date: Date
    var title: String
    var itemDescription: String
    var priority: Priority
    var tags: [String]
    
    init(date: Date, title: String, itemDescription: String, priority: Priority = .normal, tags: [String]) {
        self.date = date
        self.title = title
        self.itemDescription = itemDescription
        self.priority = priority
        self.tags = tags
    }
    
    var color: Color {
        switch priority {
        case .high:
            return .red
        case .low:
            return .gray
        case .normal:
            return .green
        case .medium:
            return .yellow
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM "
        let newDate = formatter.string(from: date)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        let dayComponent =  Calendar.current.component(.day, from: date)
        let formattedDay = numberFormatter.string(from: NSNumber(value: dayComponent))
        let dateString = "\(newDate) \(formattedDay ?? "")"
        return dateString
    }
}

enum Priority: String, Codable, CaseIterable {
    case normal
    case low
    case medium
    case high
}
