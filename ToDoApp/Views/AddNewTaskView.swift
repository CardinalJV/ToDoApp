  //
  //  AddToDoView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //

import SwiftUI

struct AddNewTaskView: View {
  
  var targetList: ListModel
  
  @State var name = ""
  @State var priority = ""
  @State var task_vm = TaskViewModel()
  @State private var isActive_alert = false
  
  @Binding var isPresented: Bool
  
  func createTask() {
      // Vérifie que les champs ne sont pas vides
    if name.isEmpty {
      isActive_alert.toggle()
    } else {
      Task{
        await task_vm.createTask(name: self.name, priority: self.priority, lists: [targetList.id])
      }
    }
  }
  
  var body: some View {
    NavigationStack{
      VStack{
        List{
          TextField("Ajouter un nom", text: $name)
          TextField("Priority entre 1 et 3", text: $priority)
        }
      }
      .navigationTitle("Nouveau rappel")
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
          Button(action: {
            createTask()
            isPresented = false
          }) {
            Text("Ajouter")
          }
        }
      }
    }
  }
}

  //#Preview {
  //  AddNewTaskView()
  //}
