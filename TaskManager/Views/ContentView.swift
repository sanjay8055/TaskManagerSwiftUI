//
//  ContentView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 10/01/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.date, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        VStack(spacing: 15) {
                            HStack {
                                Text(item.title)
                                    .fontWeight(.bold)
                                Spacer()
                                Image(systemName: item.icon)
                            }
                            HStack {
                                Text("Priority: \(item.priority)")
                                    .fontWeight(.light)
                                Spacer()
                                Text(item.date, format: Date.FormatStyle(date: .abbreviated))
                                    .fontWeight(.light)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: AddTaskView()) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
