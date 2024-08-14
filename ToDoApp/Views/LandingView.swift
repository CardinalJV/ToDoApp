  //
  //  ContentView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //
import SwiftUI

struct LandingView: View {
  
  @State var isPresented_Task = false
  @State var isPresented_List = false
  @State var list_vm = ListViewModel()
  
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
            Spacer()
            Button(action: {isPresented_List.toggle()}, label: {
              Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
            })
            .bold()
            Spacer()
          }
          .padding(4)
          .background(Color(.systemGray6))
          .sheet(isPresented: $isPresented_List) {
            AddNewListView(isPresented: $isPresented_List)
          }
        }
        .task {
          await list_vm.readLists()
        }
        .onChange(of: isPresented_List){
          Task{
            await list_vm.readLists()
          }
        }
        .padding()
      }
    }
  }
}

#Preview {
  LandingView()
}
