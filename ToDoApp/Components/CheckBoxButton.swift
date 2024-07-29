//
//  CheckBoxButton.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 22/07/2024.
//

import Foundation
import SwiftUI

struct CheckBoxButton: View {
  
  @State private var isCompleted = false
  
  var body: some View {
    Button(action: {
      self.isCompleted.toggle()
    }) {
      Image(systemName: self.isCompleted ? "checkmark.circle.fill" : "circle")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(self.isCompleted ? .green : .gray)
    }
  }
}
