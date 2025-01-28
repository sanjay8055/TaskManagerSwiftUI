//
//  TaskDetailView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 13/01/25.
//

import SwiftUI

struct TaskDetailView: View {
    private let taskDetails: Item
    
    init(taskDetails: Item) {
        self.taskDetails = taskDetails
    }
    
    var body: some View {
        NavigationView {
            List {
                Text(taskDetails.title)
                    .font(.title2.weight(.medium))
                VStack(alignment: .leading, spacing: 15) {
                    Text("Description")
                        .font(.footnote)
                    Text(taskDetails.itemDescription)
                        .font(.headline.weight(.light))
                }
                .padding(.vertical)
                VStack(alignment: .leading, spacing: 15) {
                    Text("Due Date")
                        .font(.footnote)
                    Text("\(taskDetails.formattedDate)")
                        .font(.system(size: 20))
                }
                .padding(.vertical)
                VStack(alignment: .leading, spacing: 15) {
                    Text("Priority")
                        .font(.body)
                        .font(.footnote)
                    Text("\(taskDetails.priority.rawValue.capitalized)")
                        .font(.title.weight(.medium))
                        .foregroundStyle(taskDetails.color)
                    TagView(tagList: taskDetails.tags, columCount: 3)
                }
                .padding(.vertical)
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationTitle("Task Details")
    }
}

#Preview {
    TaskDetailView(taskDetails: Item(date: Date(), title: "Task Name", itemDescription: "Task description in detail", tags: []))
}
