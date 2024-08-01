  //
  //  AddNewTaskDetailView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 30/07/2024.
  //

import SwiftUI

struct AddNewTaskDetailView: View {
  
  let pictureColor: String
  @Binding var date: Date
  @Binding var hour: Date
  var priorityItem = ["Aucune", "Faible", "Moyenne", "Élevé"]
  @State var priority = "Aucune"
  @Binding var useDate: Bool
  @Binding var useHour: Bool
  
  
  var body: some View {
    NavigationStack{
      VStack(spacing: 0){
        List{
          Section{
            HStack{
              ZStack{
                RoundedRectangle(cornerRadius: 5)
                  .foregroundStyle(ColorsModel().colorFromString(pictureColor))
                  .frame(width: 30, height: 30)
                Image(systemName: "calendar")
                  .foregroundStyle(.white)
              }
              Text("Date")
              Toggle(isOn: $useDate, label: {
                EmptyView()
              })
              .tint(ColorsModel().colorFromString(pictureColor))
            }
            if useDate {
              DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .tint(ColorsModel().colorFromString(pictureColor))
            }
            HStack{
              ZStack{
                RoundedRectangle(cornerRadius: 5)
                  .foregroundStyle(ColorsModel().colorFromString(pictureColor))
                  .frame(width: 30, height: 30)
                Image(systemName: "calendar")
                  .foregroundStyle(.white)
              }
              Text("Heure")
              Toggle(isOn: $useHour, label: {
                EmptyView()
              })
              .tint(ColorsModel().colorFromString(pictureColor))
            }
            if useHour {
              DatePicker("", selection: $hour, displayedComponents: .hourAndMinute)
                .datePickerStyle(WheelDatePickerStyle())
                .tint(ColorsModel().colorFromString(pictureColor))
            }
          }
          .padding(4)
          Section{
            Picker(selection: $priority) {
              ForEach(priorityItem, id: \.self) {
                Text($0).tag($0)
              }
            } label: {
              HStack{
                ZStack{
                  RoundedRectangle(cornerRadius: 5)
                    .foregroundStyle(ColorsModel().colorFromString(pictureColor))
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
          .padding(4)
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
