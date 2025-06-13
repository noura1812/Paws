//
//  PawsApp.swift
//  Paws
//
//  Created by MacBook Air M1 2020 on 07/06/2025.
//

import SwiftUI
import SwiftData
@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
