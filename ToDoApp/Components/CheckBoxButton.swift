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
  @State var task: TaskModel
  let pictureColor: String
  let task_vm = TaskViewModel()
  
  var body: some View {
    Button(action: {
      self.isCompleted.toggle()
      self.task.fields.isCompleted = self.isCompleted
      Task {
        await task_vm.updateTask(task: self.task)
      }
    }) {
      Image(systemName: self.isCompleted ? "checkmark.circle.fill" : "circle")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundColor(self.isCompleted ? ColorsModel().colorFromString(pictureColor) : .gray)
    }
  }
}
