  //
  //  ListModel.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 18/07/2024.
  //

import Foundation
import SwiftUI

struct ListResponse: Codable {
  var records: [ListModel]
}

struct ListModel: Identifiable, Codable {
  let id: String
  let createdTime: String
  let fields: ListFields
}

struct ListFields: Codable {
  var tasks: [String]? = nil
  let title: String
  let itemCount: Int
  let picture: String
  let pictureColor: String
}
