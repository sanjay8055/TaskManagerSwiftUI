//
//  HomeViewModel.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 23/01/25.
//

import Combine
import SwiftData
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var searchText = ""
    var modelContext: ModelContext
    var items: [Item] = []
    var sortOrder: SortDescriptor<Item>
    
    init(modelContext: ModelContext, sortOrder: SortDescriptor<Item>) {
        self.modelContext = modelContext
        self.sortOrder = sortOrder
        self.fetchData()
    }
    
    func fetchData() {
        do {
            let descriptor = FetchDescriptor<Item>(sortBy: [sortOrder])
            items = try modelContext.fetch(descriptor)
        } catch {
            print("Fetch failed\(error.localizedDescription)")
        }
    }

    var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func deleteItems(item: Item) {
        withAnimation {
            modelContext.delete(item)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        if let sourceIndex = source.first {
            switch destination {
            case 0:
                items[sourceIndex].priority = .high
                items[destination].priority = .low
            case 1:
                items[sourceIndex].priority = .medium
                items[destination].priority = .normal
            case 2:
                items[sourceIndex].priority = .normal
                items[destination].priority = .medium

            default:
                items[sourceIndex].priority = .low
                items[destination].priority = .high

            }
        }
        items.move(fromOffsets: source, toOffset: destination)
    }

}
