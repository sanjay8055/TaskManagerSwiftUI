//
//  AddTaskViewModelTests.swift
//  TaskManagerTests
//
//  Created by Sanjay Raskar on 24/01/25.
//

import XCTest
@testable import TaskManager
import SwiftData

final class AddTaskViewModelTests: XCTestCase {
    var viewModel: AddTaskViewModel!

    override func setUpWithError() throws {
        viewModel = AddTaskViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testsetUpInitialValue() throws {
        //Given
        let dateTimeNow = Date()
        let item = Item(date: dateTimeNow, title: "Test", itemDescription: "Description", tags: ["Test", "Debug"])
        // When
        viewModel.setUpInitialValue(task: item)
        // Then
        XCTAssertEqual(viewModel.date, dateTimeNow)
        XCTAssertEqual(viewModel.titleText, "Test")
        XCTAssertEqual(viewModel.description, "Description")
        XCTAssertEqual(viewModel.tags, "Test,Debug")
    }

    @MainActor
    func testAddItem() throws {
        // Given
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        let item = Item(date: Date(), title: "Test", itemDescription: "Description", tags: ["Test", "Debug"])
        viewModel.setUpInitialValue(task: item)
        // When
        viewModel.addorUpdateItem(context: container.mainContext)
        // Then
        let result = try container.mainContext.fetch(FetchDescriptor<Item>())
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
        XCTAssertFalse(viewModel.showAlert)
    }
    
    @MainActor
    func testUpdateItem() throws {
        // Given
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        let item = Item(date: Date(), title: "Test1", itemDescription: "Description", tags: ["Test", "Debug"])
        viewModel = AddTaskViewModel(taskDetails: item)
        // When
        viewModel.addorUpdateItem(context: container.mainContext)
        // Then
        XCTAssertTrue(viewModel.errorMessage.isEmpty)
        XCTAssertFalse(viewModel.showAlert)
    }

    @MainActor
    func testAddItemInvalidData() throws {
        // Given
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        // When
        viewModel.addorUpdateItem(context: container.mainContext)
        // Then
        XCTAssertTrue(!viewModel.errorMessage.isEmpty)
        XCTAssertTrue(viewModel.showAlert)
    }
    
    func testTitleText() {
        // When viewModel initialised without existing data
        // Then
        XCTAssertEqual(viewModel.createButtonString, "Create")
        XCTAssertEqual(viewModel.navigationTitle, "New Task")
        
        // When
        let item = Item(date: Date(), title: "Test1", itemDescription: "Description", tags: ["Test", "Debug"])
        viewModel = AddTaskViewModel(taskDetails: item)
        
        // Then
        XCTAssertEqual(viewModel.createButtonString, "Update")
        XCTAssertEqual(viewModel.navigationTitle, "Edit Task")
    }
}
