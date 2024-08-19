//
//  ListViewModel.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 18/07/2024.
//

import Foundation

@Observable class ListViewModel {
  
  var lists = [ListModel]()
  
  private let apiUrl = "https://api.airtable.com/v0/app3Dfn6h8N2Wzzty/Lists"
  private let apiToken = "patYRbCYvSI0gxfgE.1cf151356d8b06aa3dca4e81334401120accecbc5b7fac6518606be1d6132291"
  
  // Create
  func createList(title: String, pictureColor: String) async {

    let url = URL(string: apiUrl)!
    
    let jsonObject: [String: Any] = [
      "fields": [
        "title": title,
        "tasks": [],
        "picture": "calendar.circle.fill",
        "pictureColor": pictureColor
      ]
    ]
    
    do {
      
      let newList = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = newList
      
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
  @MainActor func readLists() async {
    
    let url = URL(string: apiUrl)!
    
    var request = URLRequest(url: url)
    request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
    
    do {

      let (data, _) = try await URLSession.shared.data(for: request)
      
      let decodedData = try JSONDecoder().decode(ListResponse.self, from: data)
      
      self.lists = decodedData.records
      
    } catch {
      
      print(error.localizedDescription)
      
    }
  }
  
  // Delete
  func deleteList(id: String) async {
    
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
          if let index = lists.firstIndex(where: { $0.id == id }) {
            lists.remove(at: index)
          }
        } else {
          print("Failed to delete list: \(httpResponse.statusCode)")
        }
      }
    } catch {
      
      print(error.localizedDescription)
      
    }
  }
}
