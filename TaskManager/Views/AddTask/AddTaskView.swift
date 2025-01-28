//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 10/01/25.
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var addtaskViewModel: AddTaskViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    private var taskDetails: Item?
    
    init(viewModel: AddTaskViewModel) {
        self.addtaskViewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    FormFieldInputView(text: $addtaskViewModel.titleText, fieldTitle: "Task Title", placeHolder: "Enter task title", fieldError: $addtaskViewModel.titleError)
                        .listRowSeparator(.hidden)
                    
                    FormFieldInputView(text: $addtaskViewModel.description, fieldTitle: "Task Description", placeHolder: "Enter task description", fieldError: $addtaskViewModel.descriptionError, fieldType: .textDescription)
                        .listRowSeparator(.hidden)
                    
                    FormFieldInputView(fieldTitle: "Due Date", fieldType: .datePicker, date: $addtaskViewModel.date)
                        .listRowSeparator(.hidden)
                    
                    FormFieldInputView(text: $addtaskViewModel.tags, fieldTitle: "Tags", placeHolder: "Enter comma separated values")
                        .listRowSeparator(.hidden)
                    
                    FormFieldInputView(text: $addtaskViewModel.priority, fieldTitle: "Priority", fieldType: .picker, pickerInput: Priority.allCases.map { String($0.rawValue) })
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .navigationBarTitleDisplayMode(.inline)
                Button(addtaskViewModel.createButtonString) {
                    addItem()
                }
                .frame(width: 200, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blue)
                )
                .foregroundStyle(.white)
            }
        }
        .alert(addtaskViewModel.errorMessage, isPresented: $addtaskViewModel.showAlert) {
        }
        .navigationTitle(addtaskViewModel.navigationTitle)
    }
    
    private func addItem() {
        addtaskViewModel.addorUpdateItem(context: modelContext)
        if addtaskViewModel.errorMessage.isEmpty {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    AddTaskView(viewModel: AddTaskViewModel())
}
