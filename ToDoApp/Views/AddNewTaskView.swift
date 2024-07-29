  //
  //  AddToDoView.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //

import SwiftUI

struct AddNewTaskView: View {
  
  @State var name = ""
  @State var priority = ""
  @State var task_vm = TaskViewModel()
  var targetList: ListModel
  
  var body: some View {
    VStack{
      List{
        TextField("Ajouter un nom", text: $name)
        TextField("Priority entre 1 et 3", text: $priority)
      }
      Button(action: {
        Task{
          await task_vm.createTask(name: self.name, priority: self.priority, lists: [targetList.id])
        }
      }, label: {
        Text("Add New Todo")
      })
    }
    .toolbar{
      ToolbarItem(placement: .topBarLeading) {
        Text("Annuler")
      }
        //        ToolbarItem(placement: .topBarLeading) {
        //          Text("Nouveau Rappel")
        //        }
      ToolbarItem(placement: .topBarTrailing) {
        Text("Ajouter")
      }
    }
  }
}

//#Preview {
//  AddNewTaskView()
//}
