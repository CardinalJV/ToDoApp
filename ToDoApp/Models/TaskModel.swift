  //
  //  ToDo.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 15/07/2024.
  //

import Foundation

struct TasksResponse: Codable {
  var records: [TaskModel]
}

struct TaskModel: Identifiable, Codable {
  var id: String? = nil
  var createdTime: String? = nil
  var fields: TaskModelFields
}

struct TaskModelFields: Codable {
  var lists: [String]
  var name: String
  var dateToNotify: String? = nil
  var priority: String
  var isCompleted: Bool? = nil
  var notes: String? = nil
  
  func formattedDateAndTime(dateToNotify: String? = nil) -> String? {
    let dateString = dateToNotify ?? self.dateToNotify
    
    guard let iso8601String = dateString else {
      return nil
    }
    
      // Convertir l'ISO 8601 en Date
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    guard let date = inputFormatter.date(from: iso8601String) else {
      return nil
    }
    
      // Convertir la Date en chaîne formatée
    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd/MM/yyyy HH:mm"
    outputFormatter.timeZone = TimeZone.current
    
    return outputFormatter.string(from: date)
  }
  
  func convertPriority(priority: String? = nil) -> String {
    switch priority {
      case "Faible": return "!"
      case "Moyenne": return "!!"
      case "Élevée": return "!!!"
      default: return ""
    }
  }
}
