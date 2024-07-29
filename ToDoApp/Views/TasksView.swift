//
//  TasksView.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 18/07/2024.
//

import SwiftUI

struct TasksView: View {
  
  @State var isActive = false
  @State var task_vm = TaskViewModel()
  @State var list_vm = ListViewModel()
  var targetList: ListModel
  
  func sortTasks() -> [TaskModel] {
    var sortedTasks: [TaskModel] = []
    for task in task_vm.tasks {
      if task.fields.lists[0] == targetList.id {
        sortedTasks.append(task)
      }
    }
    return sortedTasks
  }
  
  func fetchData() {
    Task {
      await task_vm.readTasks()
      await list_vm.readLists()
    }
  }
  
    var body: some View {
      NavigationStack{
        VStack(spacing: 0){
          if sortTasks().isEmpty {
            ZStack {
              Color.white
              ProgressView("Chargement en cours...")
                .progressViewStyle(CircularProgressViewStyle())
                .foregroundColor(.white)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .tint(.white)
            }
          } else {
            List(sortTasks()){ task in
              HStack{
                Text(task.fields.name)
                Spacer()
                CheckBoxButton()
              }
            }
            HStack{
              Button(action: {isActive.toggle()}, label: {
                Image(systemName: "plus.circle.fill")
                  .font(.title)
                Text("Rappel")
                  .font(.title3)
              })
              .bold()
              Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .sheet(isPresented: $isActive) {
              AddNewTaskView(targetList: targetList )
            }
          }
        }
        .onAppear(){
          fetchData()
          sortTasks()
        }
      }
    }
}
