  //
  //  AddToDoView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //

import SwiftUI

struct AddNewTaskView: View {
    // Propriétés liée au model
  var targetList: ListModel
  @State var task_vm = TaskViewModel()
  @State var list_vm = ListViewModel()
  
    // Propriétes lier a la navigation
  @State private var isActive_alert = false
  @State var hasTapped = false
  @Binding var isPresented: Bool
  
    // Propriétés lier au ViewModel
  @State var priority = "Aucune"
  @State var name = ""
  @State var notes = "Notes"
  @State var date = Date()
  @State var hour = Date()
  
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
        await task_vm.createTask(name: self.name, priority: self.priority, lists: [targetList.id], notes: self.notes)
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
            NavigationLink("Détails", destination: AddNewTaskDetailView(date: self.$date, hour: self.$hour))
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
  //  AddNewTaskView()
  //}
