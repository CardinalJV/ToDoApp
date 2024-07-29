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
  let id: String
  let createdTime: String
  let fields: TaskModelFields
}

struct TaskModelFields: Codable {
  let lists: [String]
  let name: String
  let priority: String
}
