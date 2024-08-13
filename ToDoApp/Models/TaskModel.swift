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
  var priority: String? = nil
  var isCompleted: Bool? = nil
  var notes: String? = nil
}
