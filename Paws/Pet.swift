//
//  Pit.swift
//  Paws
//
//  Created by MacBook Air M1 2020 on 07/06/2025.
//

import Foundation
import SwiftData

@Model
class Pet{
    var name:String
    @Attribute(.externalStorage) var photo: Data?
    init(name: String, photo: Data? = nil) {
        self.name = name
        self.photo = photo
    }
}
extension Pet{
    @MainActor
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Pet.self, configurations: config)
        container.mainContext.insert(Pet(name: "xx1"))
        container.mainContext.insert(Pet(name: "xx2"))
        container.mainContext.insert(Pet(name: "xx3"))
        container.mainContext.insert(Pet(name: "xx4"))
        container.mainContext.insert(Pet(name: "xx5"))
        container.mainContext.insert(Pet(name: "xx6"))
        container.mainContext.insert(Pet(name: "xx7"))
        container.mainContext.insert(Pet(name: "xx8"))
        container.mainContext.insert(Pet(name: "xx9"))
        return container
    }
}
