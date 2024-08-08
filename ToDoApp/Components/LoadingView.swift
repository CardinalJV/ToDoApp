//
//  ProgressView.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 29/07/2024.
//

import SwiftUI

struct LoadingView: View {
  
  @State var listColor: String
  
    var body: some View {
      ZStack{
        Color(.systemGray6)
        ProgressView("Chargement en cours...")
          .progressViewStyle(CircularProgressViewStyle())
          .foregroundColor(.white)
          .padding()
          .background(ColorsModel().colorFromString(self.listColor))
          .cornerRadius(10)
          .tint(.white)
      }
    }
}

#Preview {
    ProgressView()
}
