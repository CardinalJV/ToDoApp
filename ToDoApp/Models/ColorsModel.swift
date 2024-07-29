//
//  ColorsModel.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 25/07/2024.
//

import Foundation
import SwiftUI

struct ColorsModel {
  
  let colors: [String: Color] = [
    "red": .red,
    "orange": .orange,
    "yellow": .yellow,
    "green": .green,
    "blue": .blue,
    "purple": .purple,
    "brown": .brown,
    "default": .gray
  ]
  // Convertis un type String en Color
  func colorFromString(_ pictureColor: String) -> Color {
    return colors[pictureColor.lowercased()] ?? .clear
  }
  // Convertis un type Color en String
  func stringFromColor(_ pictureColor: Color) -> String {
    return colors.first(where: { $0.value == pictureColor })?.key ?? colors.first(where: { $0.value == .gray })!.key
  }
  
}
