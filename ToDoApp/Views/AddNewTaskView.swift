  //
  //  AddToDoView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //

import SwiftUI

struct AddNewTaskView: View {
    // Propriétés liée au ViewModel
  var targetList: ListModel
  @State var task_vm = TaskViewModel()
  @State var list_vm = ListViewModel()
  
    // Propriétes lier a la navigation
  @State private var isActive_alert = false
  @State var hasTapped = false
  @Binding var isPresented: Bool
  
    // Propriétés lier au Model
  let pictureColor: String
  @State var priority = "Aucune"
  @State var name = ""
  @State var notes = "Notes"
  @State var date = Date()
  @State var useDate = false
  @State var useHour = false
  @State var hour = Date()
  
  func combineDateAndHour(date: Date?, hour: Date?) -> Date? {
    guard let date = date else {
      return nil
    }
    if let hour = hour {
      let calendar = Calendar.current
      let hourComponents = calendar.dateComponents([.hour, .minute], from: hour)
      var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
      dateComponents.hour = hourComponents.hour
      dateComponents.minute = hourComponents.minute
      return calendar.date(from: dateComponents)
    } else {
      return date
    }
  }
  
  func formatDateToISO8601(date: Date?) -> String? {
    guard let date = date else {
      return nil
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.string(from: date)
  }
  
  func fetchData() {
    Task{
      await list_vm.readLists()
    }
  }
  
  func createTask() {
      // Vérifie que les champs ne sont pas vides
    if name.isEmpty {
      isActive_alert.toggle()
    } else {
      Task{
        let formattedDate = formatDateToISO8601(date: combineDateAndHour(date: useDate ? self.date : nil, hour: useHour ? self.hour : nil))
        await task_vm.createTask(
          name: self.name,
          priority: self.priority,
          lists: [targetList.id],
          notes: self.notes,
          dateAndHourToNotify: formattedDate
        )
      }
    }
  }
  
  var body: some View {
    NavigationStack{
      VStack{
        List{
          Section{
            TextField("Ajouter un nom", text: $name)
            TextEditor(text: $notes)
              .frame(minHeight: 100)
              .foregroundStyle(hasTapped ? Color.black : Color(.systemGray3))
              .padding(-5)
              .gesture(
                TapGesture()
                  .onEnded { _ in
                      // Gestion du TextEditor
                    if !hasTapped {
                      notes = ""
                      hasTapped = true
                    }
                  }
              )
          }
          Section{
            NavigationLink("Détails", destination: AddNewTaskDetailView(pictureColor: targetList.fields.pictureColor, date: self.$date, hour: self.$hour, useDate: self.$useDate, useHour: self.$useHour))
          }
          Section{
          }
        }
      }
      .navigationBarTitle("Nouveau rappel")
      .navigationBarTitleDisplayMode(.inline)
      .alert("Champ du formulaire invalide", isPresented: $isActive_alert){}
      .toolbar{
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            isPresented = false
          }) {
            Text("Annuler")
          }
        }
        ToolbarItem(placement: .topBarTrailing) {
            // Vérifie que la nouvelle tache possède un nom avant de pouvoir l'ajouter
          if name.isEmpty {
            Text("Ajouter")
              .foregroundStyle(Color(.systemGray4))
          }
          Button(action: {
            createTask()
            isPresented = false
          }) {
            Text("Ajouter")
          }
        }
      }
    }
    .onAppear(){
      fetchData()
    }
  }
}

//#Preview {
//  LandingView()
//}
