//
//  NewPetView.swift
//  Paws
//
//  Created by MacBook Air M1 2020 on 09/06/2025.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditPetView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var pet: Pet
    @State private var photoPicker: PhotosPickerItem?

    var body: some View {

        Form {
            //MARK: -IMAGE

            if let imageData = pet.photo {
                if let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 300)
                        .padding(.top)

                }
            } else {
                CustomContentUnavailableView(
                    title: "No Photo", icon: "pawprint.circle",
                    discrebtion: "Add a photo to make it easy to fined your pet"
                )
                .padding(.top)
            }
            //MARK: -PHOTO PICKER

            PhotosPicker(
                selection: $photoPicker, matching: .images,
                label: {
                    Label("Select a Photo", systemImage: "photo.badge.plus")
                        .frame(minWidth: 0, maxWidth: .infinity)

                }
            )
            .listRowSeparator(.hidden)
            //MARK: -TEXTFIELD
            TextField(
                text: $pet.name,
                label: {
                    Text("name")
                }
            )
            .textFieldStyle(.roundedBorder)
            .padding(.vertical)
            .font(.largeTitle.weight(.light))

            //MARK: -BUTTON
            Button {
                dismiss()

            } label: {
                Text("Save")
                    .font(.title3.weight(.medium))
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .listRowSeparator(.hidden)
            .padding(.bottom)

        }
        .navigationTitle("Edit Pet")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onChange(
            of: photoPicker,
            {

                Task {
                    pet.photo = try? await photoPicker?.loadTransferable(
                        type: Data.self)
                }
            })

    }
}

#Preview {
    NavigationStack {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(
                for: Pet.self, configurations: config)
            let sampleData = Pet(name: "XXXX")

            return EditPetView(pet: sampleData).modelContainer(container)
        } catch {
            fatalError("Error loading preview\(error.localizedDescription)")
        }
    }

}
