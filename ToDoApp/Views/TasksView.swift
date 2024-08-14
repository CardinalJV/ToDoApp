  //
  //  TasksView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 18/07/2024.
  //

import SwiftUI

struct TasksView: View {
  @Environment(\.presentationMode) private var presentationMode
  
    //  @State var task_vm = TaskViewModel()
  @State var task_vm = TaskViewModel()
  var targetList: ListModel
  
  @State var isPresented_task = false
  
  var body: some View {
    NavigationStack{
      ZStack{
        Color(.systemGray6)
          .ignoresSafeArea()
        VStack(spacing: 0){
          if task_vm.isLoading {
            LoadingView(listColor: targetList.fields.pictureColor)
          } else if !task_vm.isLoading && task_vm.sortTasks(targetList: self.targetList).isEmpty {
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
            List(task_vm.sortTasks(targetList: self.targetList)){ task in
              HStack{
                VStack(alignment: .leading){
                  Text(task.fields.name)
                  if (task.fields.notes != nil) {
                    Text(task.fields.notes!)
                      .font(.subheadline)
                      .foregroundStyle(.gray)
                  }
                }
                Spacer()
                CheckBoxButton(isCompleted: task.fields.isCompleted ?? false, task: task, pictureColor: targetList.fields.pictureColor)
              }
              .swipeActions{
                Button("Supprimer") {
                  Task{
                    await task_vm.deleteTask(id: task.id!)
                  }
                }
                .tint(.red)
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
            AddNewTaskView(targetList: targetList, isPresented: $isPresented_task, pictureColor: targetList.fields.pictureColor)
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
        }
      }
    }
    .task{
      await task_vm.readTasks()
    }
    .onChange(of: isPresented_task) {
      Task {
        await task_vm.readTasks()
      }
    }
  }
}
