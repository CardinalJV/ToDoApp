  //
  //  AddNewTaskDetailView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 30/07/2024.
  //

import SwiftUI

struct AddNewTaskDetailView: View {
  
  @Binding var date: Date
  @Binding var hour: Date
  var priorityItem = ["Aucune", "Faible", "Moyenne", "Élevé"]
  @State var priority = "Aucune"
  
  
  var body: some View {
    NavigationStack{
      VStack(spacing: 0){
        List{
          Section{
            DatePicker(selection: $date, displayedComponents: .date) {
              HStack{
                ZStack{
                  RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.blue)
                    .frame(width: 30, height: 30)
                  Image(systemName: "calendar")
                    .foregroundStyle(.white)
                }
                Text("Date")
              }
            }
            DatePicker(selection: $hour, displayedComponents: .hourAndMinute) {
              HStack{
                ZStack{
                  RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.blue)
                    .frame(width: 30, height: 30)
                  Image(systemName: "clock.fill")
                    .foregroundStyle(.white)
                    .bold()
                }
                Text("Heure")
              }
            }
          }
          .padding(1)
          Section{
            Picker(selection: $priority) {
              ForEach(priorityItem, id: \.self) {
                Text($0).tag($0)
              }
            } label: {
              HStack{
                ZStack{
                  RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(.blue)
                    .frame(width: 30, height: 30)
                  Text("!")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                }
                Text("Priorité")
              }
            }
          }
          .padding(1)
        }
      }
      .navigationTitle("Détails")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

//#Preview {
//  AddNewTaskDetailView(date: .constant(), hour: <#Binding<Date>#>)
//}
