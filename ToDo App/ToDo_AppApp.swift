//
//  ToDo_AppApp.swift
//  ToDo App
//
//  Created by Jigar Shethia on 06/04/24.
//

import SwiftUI

@main
struct ToDo_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
          HomeView()
        }
    }
}
