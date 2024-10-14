  //
  //  AddNewListViewView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 23/07/2024.
  //
import Foundation
import SwiftUI

struct AddNewListView: View {
  @Environment(\.dismiss) var dismiss
  
  var list_vm: ListViewModel
  @State var title = ""
  @State private var pictureColor: [String: Color] = ["blue": .blue]
  @State private var isActive_alert = false
  @State var fieldsComplete = false
  
  let gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: 6)
  
  var body: some View {
    NavigationStack{
      ZStack{
        Color(.systemGray6)
          .ignoresSafeArea()
        VStack{
          VStack{
            ZStack{
              Circle()
                .fill(Color.white)
                .frame(width: 99, height: 99)
                .shadow(color: pictureColor.values.first!, radius: 4, x: 1, y: 1)
              Image(systemName: "calendar.circle.fill")
                .font(.system(size: 100))
                .foregroundStyle(pictureColor.values.first!)
            }
            TextField("Nom de la liste", text: $title)
              .padding()
              .foregroundStyle(pictureColor.values.first!)
              .font(.title2)
              .frame(height: 70)
              .multilineTextAlignment(.center)
              .bold()
              .background(Color(.systemGray5))
              .clipShape(.rect(cornerRadius: 10))
          }
          .padding()
          .frame(width: 350)
          .background(.white)
          .clipShape(.rect(cornerRadius: 10))
          LazyVGrid(columns: gridItems) {
            ForEach(ColorsModel().colors.keys.sorted(), id: \.self) { key in
              Button(action: { pictureColor = [key: ColorsModel().colors[key] ?? .clear] }, label: {
                Circle()
                  .fill(ColorsModel().colors[key] ?? .clear)
              })
            }
          }
          .padding()
          .frame(width: 350)
          .background(.white)
          .clipShape(.rect(cornerRadius: 10))
          Spacer()
        }
        .alert("Champ du formulaire invalide", isPresented: $isActive_alert){}
      }
      .navigationTitle("Nouvelle liste")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar{
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            self.dismiss()
          }) {
            Text("Annuler")
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
          Button(action: {
            if title.isEmpty {
              isActive_alert.toggle()
            } else {
              Task{
                await self.list_vm.createList(title: self.title, pictureColor: self.pictureColor.keys.first!)
                await self.list_vm.readLists()
              }
              self.dismiss()
            }
          }) {
            Text("Ajouter")
          }
        }
      }
    }
  }
}
