  //
  //  File.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 16/07/2024.
  //  C.R.U.D

import Foundation
import Observation

@Observable
class TaskViewModel {
  
  var tasks = [TaskModel]()
  var isLoading = true
  
  private let apiUrl = "https://api.airtable.com/v0/app3Dfn6h8N2Wzzty/Tasks"
  private let apiToken = "patYRbCYvSI0gxfgE.1cf151356d8b06aa3dca4e81334401120accecbc5b7fac6518606be1d6132291"
  
    // Create
  func createTask(name: String, priority: String, lists: [String], notes: String? = nil, dateAndHourToNotify: String?) async {
    
    let url = URL(string: apiUrl)!
    // Création de l'objet JSON qui sera envoyer dans la requete
    let jsonObject: [String: Any] = [
      "fields": [
        "name": name,
        "priority": priority,
        "lists": lists,
        "notes": notes ?? "",
        "dateToNotify": dateAndHourToNotify ?? ""
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
      
      self.isLoading = false
      
    } catch {
      
      print(error.localizedDescription)
      
    }
  }
    // Read
  func readTasks() async {
    
    let url = URL(string: apiUrl)!
    
    var request = URLRequest(url: url)
    request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
    
    do {
      
      let (data, _) = try await URLSession.shared.data(for: request)
      
      let decodedData = try JSONDecoder().decode(TasksResponse.self, from: data)
      
      self.tasks = decodedData.records
      
      self.isLoading = false
      
    } catch {
      
      print(error.localizedDescription)
      
      self.isLoading.toggle()
      
    }
  }
    // Delete
  func deleteTask(id: String) async {
    
    let url = URL(string: apiUrl + "/" + id)!
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
    
    do {
      
      let (_, response) = try await URLSession.shared.data(for: request)
        // Déballage de l'optionnal afin de vérifier l'existence de la réponse
      if let httpResponse = response as? HTTPURLResponse {
          // Si la requète réussie, statut 200, alors on supprime la tâche localement
        if httpResponse.statusCode == 200 {
          print("Suppression réussie")
          if let index = tasks.firstIndex(where: { $0.id == id }) {
            tasks.remove(at: index)
          }
        } else {
          print("Failed to delete task: \(httpResponse.statusCode)")
        }
      }
      
      self.isLoading = false
      
    } catch {
      
      print(error.localizedDescription)
      
    }
  }
}
