  //
  //  TasksView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 18/07/2024.
  //

import SwiftUI

struct TasksView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @State var isPresented_task = false
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
      ZStack{
        Color(.systemGray6)
          .ignoresSafeArea()
        VStack(spacing: 0){
          if task_vm.isLoading {
            LoadingView(listColor: targetList.fields.pictureColor)
          } else if !task_vm.isLoading && sortTasks().isEmpty {
            Spacer()
            VStack{
              Text("Aucun rappel dans cette liste.")
                .foregroundStyle(.gray)
                .bold()
              Button(action: { isPresented_task.toggle() }, label: {
                Text("Ajouter +")
                  .foregroundStyle(.white)
                  .bold()
                  .frame(width: 100, height: 40)
                  .background(ColorsModel().colorFromString(targetList.fields.pictureColor))
                  .clipShape(.rect(cornerRadius: 5))
              })
            }
            Spacer()
          } else {
            List(sortTasks()){ task in
              HStack{
                Text(task.fields.name)
                Spacer()
                CheckBoxButton()
              }
            }
          }
          HStack{
            Button(action: {isPresented_task.toggle()}, label: {
              Image(systemName: "plus.circle.fill")
                .font(.title)
                .foregroundStyle(ColorsModel().colorFromString(targetList.fields.pictureColor))
              Text("Rappel")
                .font(.title3)
                .foregroundStyle(ColorsModel().colorFromString(targetList.fields.pictureColor))
            })
            .bold()
            Spacer()
          }
          .padding()
          .background(Color(.systemGray6))
          .sheet(isPresented: $isPresented_task) {
            AddNewTaskView(targetList: targetList, isPresented: $isPresented_task )
          }
          .navigationBarBackButtonHidden(true)
          .navigationTitle(targetList.fields.title)
        }
        .toolbar{
          ToolbarItem(placement: .topBarLeading) {
            Button(action: {
              // Retourne a la vue parente 
              presentationMode.wrappedValue.dismiss()
            }) {
              HStack{
                Image(systemName: "arrow.left")
                Text("Listes")
                  .font(.title3)
              }
              .foregroundStyle(ColorsModel().colorFromString(targetList.fields.pictureColor))
              .bold()
            }
          }
//          ToolbarItem(placement: .topBarTrailing) {
//            Button(action: {
//            
//            }) {
//              Text("Ajouter")
//            }
//          }
        }
      }
    }
    .onAppear(){
      fetchData()
    }
  }
}

  //#Preview {
  //  TasksView(targetList: )
  //}
