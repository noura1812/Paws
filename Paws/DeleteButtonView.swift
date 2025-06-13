//
//  DeleteButtonView.swift
//  Paws
//
//  Created by MacBook Air M1 2020 on 10/06/2025.
//

import SwiftUI

struct DeleteButtonView: View {
    let action: () -> Void

    var body: some View {
        Menu(
            content: {
                Button(
                    "Delete",
                    systemImage: "trash",
                    role: .destructive
                ) {
                    withAnimation{
                        action()
                    }
                }
            },
            label: {
                Image(
                    systemName:
                        "trash.circle.fill"
                )
                .resizable()
                .aspectRatio(
                    contentMode: .fill
                )
                .frame(
                    width: 36, height: 36
                )
                .foregroundStyle(.red)
                .symbolRenderingMode(
                    .multicolor
                )
                .padding()
            })
    }
}

#Preview {
    DeleteButtonView(action: {
        
    })
}
