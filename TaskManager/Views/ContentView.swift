//
//  ContentView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 10/01/25.
//

import SwiftUI

struct ContentView: View {
    @State private var sortOrder = SortDescriptor(\Item.title)
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            HomeView(viewModel: HomeViewModel(modelContext: modelContext, sortOrder: sortOrder))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        menuPicker
                    }
                }
                .navigationTitle("Tasks List")
        }
    }
    
    var menuPicker: some View {
        Menu("Sort", systemImage: "arrow.up.arrow.down") {
            Picker("Sort", selection: $sortOrder) {
                Text("Name")
                    .tag(SortDescriptor(\Item.title))
                Text("Date")
                    .tag(SortDescriptor(\Item.date))
            }
            .pickerStyle(.inline)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
