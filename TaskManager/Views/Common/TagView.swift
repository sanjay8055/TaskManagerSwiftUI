//
//  TagView.swift
//  TaskManager
//
//  Created by Sanjay Raskar on 17/01/25.
//

import SwiftUI

struct TagView: View {
    private var columCount: Int
    private var columns: [GridItem]
    private var tagList: [String]

    init(tagList: [String], columCount: Int = 2) {
        self.columns = Array(repeating: GridItem(.flexible(), alignment: .leading), count: columCount)
        self.columCount = columCount
        self.tagList = tagList
    }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(tagList, id: \.self) { tag in
                Text("\(tag)")
                    .frame(maxWidth: .infinity)
                    .font(.body)
                    .padding(10)
                    .foregroundColor(Color.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.mint.opacity(0.3))
                            .strokeBorder( Color.mint, lineWidth: 2)
                    )
            }
        }
    }
}

#Preview {
    TagView(tagList: ["test me", "assignment"])
}
