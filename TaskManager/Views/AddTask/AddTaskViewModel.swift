//
//  AddTaskViewModel.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 22/01/25.
//

import Foundation
import Combine
import SwiftData

class AddTaskViewModel: ObservableObject {
    @Published var titleText: String = ""
    @Published private var isPresented = false
    @Published var date = Date.now
    @Published var description = ""
    @Published var tags = ""
    @Published var priority = ""
    @Published var titleError = ""
    @Published var descriptionError = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    private var taskDetails: Item?
    
    init(taskDetails: Item? = nil) {
        self.taskDetails = taskDetails
        setUpInitialValue(task: taskDetails)
    }

    func addorUpdateItem(context: ModelContext) {
        if isValidForm {
            if taskDetails != nil { //update item
                taskDetails?.title = titleText
                taskDetails?.itemDescription = description
                taskDetails?.date = date
                taskDetails?.priority = Priority(rawValue: priority) ?? .normal
                taskDetails?.tags = tags.components(separatedBy: ",")
                try? context.save()
            } else { // add new item
                let newItem = Item(date: date, title: titleText, itemDescription: description, priority: Priority(rawValue: priority) ?? .normal, tags: tags.components(separatedBy: ","))
                context.insert(newItem)
            }
        } else {
            showAlert = true
            errorMessage = "Please enter all field values"
        }
    }
    
    private var isValidForm: Bool {
        return titleText.count > 3 && !description.isEmpty && description.count < 1024 && !tags.isEmpty && !priority.isEmpty
    }
    
    func setUpInitialValue(task: Item?) {
        if let task {
            titleText = task.title
            description = task.itemDescription
            tags = task.tags.joined(separator: ",")
            date = task.date
            priority = task.priority.rawValue
        }
    }
    
    var createButtonString: String {
        taskDetails == nil ? "Create" : "Update"
    }
    
    var navigationTitle: String {
        taskDetails == nil ? "New Task" : "Edit Task"
    }
    
    var formInputFields: [FormField] {
        [FormField(fieldValue: titleText, fieldTitle: "Task Title", placeHolder: "Enter Task Title", fieldError: titleError, fieldType: .textInput),
         FormField(fieldValue: description, fieldTitle: "Task Description", placeHolder: "Enter Task Description", fieldError: descriptionError, fieldType: .textDescription),
        // FormField(fieldValue: date, fieldTitle: "Due Date", fieldType: .datePicker),
         FormField(fieldValue: tags, fieldTitle: "Tags", placeHolder: "Enter comma separated values", fieldType: .textInput),
         FormField(fieldValue: priority, fieldTitle: "Priority", placeHolder: "Enter Task Title",  fieldType: .picker)]
    }
}
