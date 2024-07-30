//
//  AddNewTaskItemView.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 29/07/2024.
//

import SwiftUI

struct AddNewTaskItemView: View {
  
  @State private var textField = ""
  
    var body: some View {
      HStack{
        CheckBoxButton()
        TextField("", text: $textField)
        Spacer()
      }
    }
}

#Preview {
    AddNewTaskItemView()
}
