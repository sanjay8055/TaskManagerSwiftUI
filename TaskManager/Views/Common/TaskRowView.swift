//
//  TaskRowView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 23/01/25.
//

import SwiftUI

struct TaskRowView: View {
    let item: Item

    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(item.color)
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(item.title)
                    .fontWeight(.bold)
                Text(item.itemDescription)
                Text("Due \(item.formattedDate)")
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    TaskRowView(item: Item(date: Date(), title: "Test", itemDescription: "Test description", tags: ["test", "debug"]))
}
