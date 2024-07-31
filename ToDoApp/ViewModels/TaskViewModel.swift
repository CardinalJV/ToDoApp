  //
  //  File.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 16/07/2024.
  //  C.R.U.D

import Foundation

@Observable
class TaskViewModel {
  
  var tasks = [TaskModel]()
  var isLoading = false
  
  private let apiUrl = "https://api.airtable.com/v0/app3Dfn6h8N2Wzzty/Tasks"
  private let apiToken = "patYRbCYvSI0gxfgE.1cf151356d8b06aa3dca4e81334401120accecbc5b7fac6518606be1d6132291"
  
  // Create
  func createTask(name: String, priority: String, lists: [String], notes: String? = nil, dateToNotify: Date?) async {
    
    let url = URL(string: apiUrl)!
    
    let jsonObject: [String: Any] = [
      "fields": [
        "name": name,
        "priority": priority,
        "lists": lists,
        "notes": notes ?? "",
        "dateToNotify": dateToNotify ?? ""
      ]
    ]
    
    do {
      
      let newTask = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = newTask
      
      let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
          return print(String(describing: error))
        }
        print(String(data: data, encoding: .utf8)!)
      }
      
      task.resume()
      
    } catch {
      
      print(error.localizedDescription)
      
    }
  }
  // Read
  func readTasks() async {
    
    let url = URL(string: apiUrl)!
    
    var request = URLRequest(url: url)
    request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
    
    self.isLoading = true
    
    do {
      
      let (data, _) = try await URLSession.shared.data(for: request)
      
      let decodedData = try JSONDecoder().decode(TasksResponse.self, from: data)
      
      self.tasks = decodedData.records
      
      self.isLoading = false
      
    } catch {
      
      print(error.localizedDescription)
      
      self.isLoading = false
      
    }
  }
  // Update
//  func updateToDoTask(){}
  // Delete
//  func deleteToDoTask(){}
}
