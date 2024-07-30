//
//  KeyConstant.swift
//  ToDoApp
//
//  Created by Jessy Viranaiken on 29/07/2024.
//

import Foundation

enum KeyConstant {
  
  static func loadAPIKeys() async throws {
    
    let request = NSBundleResourceRequest(tags: ["APIKeys"])
    try await request.beginAccessingResources()
    
    let url = Bundle.main.url(forResource: "APIKeys", withExtension: "json")!
    let data = try Data(contentsOf: url)
    
    APIKeys.storage = try JSONDecoder().decode([String: String].self, from: data)
    
    request.endAccessingResources()
    
  }
  
  enum APIKeys {
    
    static fileprivate(set) var storage = [String: String]()
    static var apiUrl: String { storage["apiUrl"] ?? "" }
    static var apiToken: String { storage["apiToken"] ?? "" }
    
  }
}
