//
//  HomeView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 23/01/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.filteredItems) { item in
                    NavigationLink {
                        TaskDetailView(taskDetails: item)
                            .toolbarRole(.editor) // hide back button title
                    } label: {
                        TaskRowView(item: item)
                            .alignmentGuide(.listRowSeparatorLeading) { d in
                                d[.leading]
                            }
                            .swipeActions(content: {
                                Button(role: .destructive) {
                                    viewModel.deleteItems(item: item)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                                NavigationLink(destination: AddTaskView(viewModel: AddTaskViewModel(taskDetails: item))            .toolbarRole(.editor)) {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.indigo)
                            })
                    }
                }
                .onMove(perform: viewModel.move(from:to:))
              //  .onDelete(perform: deleteItems) //enable after remove custom swipe actions and add Edit button in toolbar
                .animation(.default, value: viewModel.filteredItems)
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchText)
            .toolbar {
                           EditButton()
                       }
            // Button
            NavigationLink(destination: AddTaskView(viewModel: AddTaskViewModel())            .toolbarRole(.editor)) {
                Text("New Task")
                    .font(.headline)
            }
            .frame(width: 200, height: 50)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 9)
                    .fill(Color.blue)
            )
        }
    }
}

#Preview {
    @Previewable
    @Environment(\.modelContext) var modelContext
    HomeView(viewModel: HomeViewModel(modelContext: modelContext, sortOrder: SortDescriptor(\Item.title)))
}
