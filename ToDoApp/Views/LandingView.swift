  //
  //  ContentView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //
import SwiftUI

struct LandingView: View {
  
  @State var isPresented_AddNewListView = false
  @State var list_vm = ListViewModel()
  @State var task_vm = TaskViewModel()
  
  var body: some View {
    NavigationStack{
      ZStack{
        Color(.systemGray6)
          .ignoresSafeArea()
        VStack(spacing: 0){
          if list_vm.lists.isEmpty {
            Text("Chargement en cours")
          } else {
            ScrollView{
              LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)], spacing: 17.5) {
                ForEach(list_vm.lists) { list in
                  NavigationLink(destination: TasksView(task_vm: self.$task_vm, targetList: list), label: {
                    ButtonList(title: list.fields.title, itemCount: list.fields.itemCount!, picture: list.fields.picture, pictureColor: list.fields.pictureColor)
                  })
                }
              }
              .padding()
            }
            Button(action: {isPresented_AddNewListView.toggle()}, label: {
              Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
            })
            .bold()
          }
        }
      }
      .sheet(isPresented: $isPresented_AddNewListView) {
        AddNewListView(list_vm: self.list_vm)
      }
      .task {
        await list_vm.readLists()
        await task_vm.readTasks()
      }
    }
  }
}

#Preview {
  LandingView()
}
