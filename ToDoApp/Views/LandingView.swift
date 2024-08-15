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
  
  var body: some View {
    NavigationStack{
      ZStack{
        Color(.systemGray6)
          .ignoresSafeArea()
        VStack(spacing: 0){
          if list_vm.lists.isEmpty {
            Text("Chargement en cours")
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
            Button(action: {isPresented_AddNewListView.toggle()}, label: {
              Image(systemName: "plus.circle.fill")
                .font(.system(size: 50))
            })
            .bold()
            Spacer()
          }
          .padding(4)
          .background(Color(.systemGray6))
          .sheet(isPresented: $isPresented_AddNewListView) {
            AddNewListView(isPresented: $isPresented_AddNewListView)
          }
        }
        .task {
          await list_vm.readLists()
        }
        .onChange(of: isPresented_AddNewListView){
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
