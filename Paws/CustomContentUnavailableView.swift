//
//  CustomContentUnavailableView.swift
//  Paws
//
//  Created by MacBook Air M1 2020 on 07/06/2025.
//

import SwiftUI

struct CustomContentUnavailableView: View {
    var title: String
    var icon: String
    var discrebtion: String

    var body: some View {
        ContentUnavailableView {
            Image(systemName: icon).resizable()
                .scaledToFit()
                .frame(width:96)
            Text(title).font(.title)
            
        } description: {
            Text(discrebtion)
        }.foregroundStyle(.tertiary)

    }
}

#Preview {
    CustomContentUnavailableView(
        title: "No photos.", icon: "cat.circle",
        discrebtion: "Add a new photo to begin.")
}
