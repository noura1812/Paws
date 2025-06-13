//
//  ContentView.swift
//  Paws
//
//  Created by MacBook Air M1 2020 on 07/06/2025.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var context: ModelContext
    @Query private var pets: [Pet]
    @State private var path = [Pet]()
    @State private var enableDelete: Bool = false
    let layout = [
        GridItem(.flexible(minimum: 120)), GridItem(.flexible(minimum: 120)),
    ]
    func addPet() {
        enableDelete=false
        let pet: Pet = Pet(name: "")
        context.insert(pet)
        path = [pet]

    }
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(
                    columns: layout
                ) {
                    GridRow {
                        ForEach(
                            pets
                        ) { pet in
                            NavigationLink(value: pet) {

                                VStack {
                                    if let imageData = pet.photo {
                                        if let image = UIImage(data: imageData)
                                        {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(
                                                    RoundedRectangle(
                                                        cornerRadius: 8,
                                                        style: .circular))
                                        }
                                    } else {
                                        Image(systemName: "pawprint.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(40)
                                            .foregroundStyle(.quaternary)
                                    }
                                    Spacer()
                                    Text(pet.name)
                                        .font(
                                            .title.weight(.light)
                                        )
                                        .padding(.vertical)
                                    Spacer()
                                }
                                .frame(
                                    minWidth: 0, maxWidth: .infinity,
                                    minHeight: 0, maxHeight: .infinity
                                )
                                .background(.ultraThinMaterial)
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 8, style: .circular)
                                )
                                .overlay(
                                    alignment: .topTrailing,
                                    content: {
                                        if enableDelete {
                                            DeleteButtonView(action: {
                                                context.delete(pet)
                                                try? context.save()
                                            })
                                        }
                                    })
                            }.foregroundStyle(.primary)

                        }
                    }
                }.padding(.horizontal)
            }
            .navigationTitle(pets.isEmpty ? "" : "Paws")
            .navigationDestination(for: Pet.self, destination: EditPetView.init)
            .toolbar {
                ToolbarItem(
                    placement: .topBarTrailing,
                    content: {
                        Button(
                            "Add pet", systemImage: "plus.circle",
                            action: addPet)
                    })

                ToolbarItem(
                    placement: .topBarLeading,
                    content: {
                        Button {
                            withAnimation{
                                enableDelete.toggle()
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                        }
                    })
            }
        }.overlay(content: {
            if pets.isEmpty {
                CustomContentUnavailableView(
                    title: "No Pets",
                    icon: "dog.circle",
                    discrebtion: "No added pets, start adding.")
            }
        })
    }
}

#Preview("No data") {
    ContentView().modelContainer(
        for: Pet.self,
        inMemory: true)
}

#Preview("Dummy data") {

    return ContentView().modelContainer(Pet.preview)
}
