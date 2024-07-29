//
//  ButtonList.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 22/07/2024.
//

import Foundation
import SwiftUI

struct ButtonList: View {
  
  @State var title: String
  @State var itemCount: Int
  @State var picture: String
  @State var pictureColor: String
  
  var body: some View {
    VStack(alignment: .leading){
      HStack{
        Image(systemName: "calendar.circle.fill")
          .font(.system(size: 35))
          .foregroundStyle(ColorsModel().colorFromString(self.pictureColor))
        Spacer()
        Text("\(itemCount)")
          .font(.title)
      }
      .bold()
      Spacer()
      Text(title)
        .bold()
        .foregroundStyle(.gray)
        .font(.title3)
    }
    .padding()
    .frame(width: 170, height: 85)
    .background(.white)
    .clipShape(.rect(cornerRadius: 15))
  }
}
