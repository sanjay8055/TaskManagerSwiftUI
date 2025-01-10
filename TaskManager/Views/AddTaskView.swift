//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 10/01/25.
//

import SwiftUI
import SFSymbolsPicker

struct AddTaskView: View {
    @State var titleText: String = ""
    @State var showDropDown = false
    @State private  var selectedOptionIndex =  0
    @State private  var showDropdown = false
    private let options = ["Normal", "High", "Low"]
    @State private var icon = "star.fill"
    @State private var isPresented = false

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                TextField("Enter title", text: $titleText)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray , lineWidth: 1)
                        )
                Text("Select Task priority")
                DropDownMenu(options: options, selectedOptionIndex: $selectedOptionIndex, showDropdown: $showDropdown)
                HStack {
                    Button {
                        isPresented.toggle()
                    } label: {
                        HStack {
                            Text("Select a symbol")
                            Image(systemName: icon).font(.title3)
                                .sheet(isPresented: $isPresented, content: {
                                    SymbolsPicker(selection: $icon, title: "Choose your symbol", autoDismiss: true) {
                                        Image(systemName: "xmark")
                                    }
                                })
                        }
                        .foregroundStyle(Color.black)
                    }
                    .padding()
                }
                Spacer()
                HStack(alignment: .center) {
                    Button("Save") {
                        addItem()
                    }.padding()
                        .frame(maxWidth: .infinity)
                        .overlay( Capsule(style: .circular).stroke(lineWidth: 1))
                }
            }
            .padding()
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(date: Date(), title: titleText, icon: icon, priority: Priority(rawValue: selectedOptionIndex) ?? .normal)
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    AddTaskView()
}
