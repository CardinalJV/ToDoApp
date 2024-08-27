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
  @Binding var task_vm: TaskViewModel
  
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
  @State var hour = Date()
  @State var useDate = false
  @State var useHour = false
  
  func createTask() {
    if name.isEmpty {
      isActive_alert.toggle()
    } else {
      Task{
        let formattedDate = date.formatDateToISO8601(date: date.combineDateAndHour(date: useDate ? self.date : nil, hour: useHour ? self.hour : nil))
        let newTask = TaskModel(
          id: nil, // Créer par le serveur
          createdTime: nil, // Créer par le serveur
          fields: TaskModelFields(
            lists: [targetList.id!],
            name: self.name,
            dateToNotify: formattedDate,
            priority: self.priority,
            isCompleted: false, // Initialisation par défaut
            notes: self.notes == "Notes" ? nil : self.notes
          )
        )
        await task_vm.createTask(newTask)
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
            NavigationLink("Détails", destination: AddNewTaskDetailView(pictureColor: targetList.fields.pictureColor, date: self.$date, hour: self.$hour, useDate: self.$useDate, useHour: self.$useHour, priority: self.$priority))
          }
        }
      }
      .navigationBarTitle("Nouveau rappel")
      .navigationBarTitleDisplayMode(.inline)
      .alert("Champ du formulaire invalide", isPresented: $isActive_alert){}
      .toolbar{
        ToolbarItem(placement: .topBarLeading) {
          Button(action: {
            self.isPresented.toggle()
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
            self.isPresented.toggle()
          }) {
            Text("Ajouter")
          }
        }
      }
    }
  }
}
