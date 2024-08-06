//
//  CheckBoxButton.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 22/07/2024.
//

import Foundation
import SwiftUI

struct CheckBoxButton: View {
  
  @State var isCompleted: Bool
  let task: TaskModel
  let pictureColor: String
  let task_vm = TaskViewModel()
  
  var body: some View {
    Button(action: {
      self.isCompleted.toggle()
      Task {
        await task_vm.deleteTask(id: self.task.id)
      }
    }) {
      Image(systemName: self.isCompleted ? "checkmark.circle.fill" : "circle")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(self.isCompleted ? ColorsModel().colorFromString(pictureColor) : .gray)
    }
  }
}
