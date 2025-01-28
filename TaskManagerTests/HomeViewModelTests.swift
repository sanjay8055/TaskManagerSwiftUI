//
//  HomeViewModelTests.swift
//  TaskManagerTests
//
//  Created by Sanjay Raskar on 24/01/25.
//

import XCTest
@testable import TaskManager
import SwiftData

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var container: ModelContainer!

    @MainActor
    override func setUpWithError() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        container = try ModelContainer(for: Item.self, configurations: config)
        let item = Item(date: Date(), title: "Test1", itemDescription: "Description", tags: ["Test", "Debug"])
        let item2 = Item(date: Date(), title: "Test2", itemDescription: "Description", priority: .high, tags: ["Test", "Debug"])
        container.mainContext.insert(item)
        container.mainContext.insert(item2)
        viewModel = HomeViewModel(modelContext: container.mainContext, sortOrder: SortDescriptor(\Item.date))
        
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testfetchData() throws {
        // When
       // viewModel initialised with data
        // Then
        XCTAssertEqual(viewModel.items.count, 2)
    }
    
    func testdeleteItems() throws {
        // Given
        let expectation = expectation(description: "deleteItems method should delete passed item")
        // When
        viewModel.deleteItems(item: viewModel.items.first!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            viewModel.fetchData()
            XCTAssertEqual(viewModel.filteredItems.count, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testMoveItems() throws {
        // When
        viewModel.move(from: IndexSet([0]), to: 1)
        XCTAssertEqual(viewModel.items.first?.priority, .medium)
        XCTAssertEqual(viewModel.items.last?.priority, .normal)
    }
}
