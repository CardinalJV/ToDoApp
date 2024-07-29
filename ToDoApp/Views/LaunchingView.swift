  //
  //  ContentView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //
import SwiftUI

struct LaunchingView: View {
  
  @State var isActive_Task = false
  @State var isActive_List = false
  @State var list_vm = ListViewModel()
  
  func fetchData() {
    Task {
      await list_vm.readLists()
    }
  }
  
  var body: some View {
    NavigationStack{
      ZStack{
        Color(.systemGray6)
          .ignoresSafeArea()
        VStack(spacing: 0){
          if list_vm.lists.isEmpty {
            Text("C'est vide")
          } else {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
              ForEach(list_vm.lists) { list in
                NavigationLink(destination: TasksView(targetList: list), label: {
                  ButtonList(title: list.fields.title, itemCount: list.fields.itemCount, picture: list.fields.picture, pictureColor: list.fields.pictureColor)
                })
              }
            }
          }
          Spacer()
          HStack{
            Button(action: {isActive_Task.toggle()}, label: {
              Image(systemName: "plus.circle.fill")
                .font(.title)
              Text("Rappel")
                .font(.title3)
            })
            .bold()
            Spacer()
            Button("Ajouter une liste"){
              isActive_List.toggle()
            }
            .font(.title3)
          }
          .padding(4)
          .background(Color(.systemGray6))
          .sheet(isPresented: $isActive_List) {
            AddNewListView(isPresented: $isActive_List)
          }
        }
        .onAppear(){
          fetchData()
        }
        .padding()
      }
//      .ignoresSafeArea() 
    }
  }
}

#Preview {
  LaunchingView()
}

  //#Preview {
  //  ButtonList(title: "Today", itemCount: 2, picture: "calendar.circle.fill", pictureColor: "blue")
//}
