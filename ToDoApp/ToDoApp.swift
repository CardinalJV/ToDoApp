  //
  //  ToDoAppApp.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //

import SwiftUI

@main
struct ToDoApp: App {
  var body: some Scene {
    WindowGroup {
      LandingView()
//        .task {
//          do {
//            try await KeyConstant.loadAPIKeys()
//          } catch {
//            debugPrint(error.localizedDescription)
//          }
//        }
    }
  }
}
