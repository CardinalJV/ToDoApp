  //
  //  ListModel.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 18/07/2024.
  //

import SwiftUI

struct ListResponse: Codable, Equatable {
  var records: [ListModel]
}

struct ListModel: Identifiable, Codable, Equatable {
  var id: String? = nil
  var createdTime: String? = nil
  let fields: ListFields
}

struct ListFields: Codable, Equatable {
  var tasks: [String]? = nil
  let title: String
  var itemCount: Int? = nil
  let picture: String
  let pictureColor: String
}
