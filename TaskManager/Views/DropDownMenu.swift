//
//  DropDownMenu.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 10/01/25.
//

import SwiftUI

struct DropDownMenu1: View {
    var items: [String] = []
    @State private  var selectedItem: String = ""
    
    var body: some View {
        VStack {
            Menu(content: {
                Picker("items", selection: $selectedItem) {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }
            }, label: {
                (Text("\(selectedItem) ") + Text(Image(systemName: "chevron.up")))
            })
            .padding(.all, 16)
            .foregroundStyle(Color.black)
            .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 1))
        }
    }
}

struct  DropDownMenu: View {
    let options: [String]
    var buttonHeight: CGFloat  =  50
    var maxItemDisplayed: Int  =  3
    
    @Binding  var selectedOptionIndex: Int
    @Binding  var showDropdown: Bool
    @State  private  var scrollPosition: Int?
    
    var body: some  View {
        VStack {
            VStack(spacing: 0) {
                // selected item
                Button(action: {
                    withAnimation {
                        showDropdown.toggle()
                    }
                }, label: {
                    HStack(spacing: nil) {
                        Text(options[selectedOptionIndex])
                        Spacer()
                        Image(systemName: "chevron.down")
                            .rotationEffect(.degrees((showDropdown ?  -180 : 0)))
                    }
                })
                .frame(height: buttonHeight, alignment: .leading)
                Divider()
                    .background(Color.white)

                // selection menu
                if (showDropdown) {
                    let scrollViewHeight: CGFloat  = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Button(action: {
                                    withAnimation {
                                        selectedOptionIndex = index
                                        showDropdown.toggle()
                                    }
                                }, label: {
                                    HStack {
                                        Text(options[index])
                                        Spacer()
                                        if (index == selectedOptionIndex) {
                                            Image(systemName: "checkmark.circle.fill")
                                        }
                                    }
                                })
                                .frame(height: buttonHeight, alignment: .leading)
                                Divider()
                                    .background(Color.white)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollPosition(id: $scrollPosition)
                    .scrollDisabled(options.count <=  maxItemDisplayed)
                    .frame(height: scrollViewHeight)
                    .onAppear {
                        scrollPosition = selectedOptionIndex
                    }
                }
            }
            .padding(.horizontal, 20)
            .foregroundStyle(Color.white)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.gradient))
        }
        .frame(height: buttonHeight, alignment: .top)
        .zIndex(100)
    }
}

#Preview {
    //DropDownMenu1(items: ["test", "test1"])
    DropDownMenu(options: ["test", "test1", "test2", "test3"], selectedOptionIndex: .constant(0), showDropdown: .constant(true))
}
