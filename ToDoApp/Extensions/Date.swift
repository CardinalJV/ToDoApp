  //
  //  Date.swift
  //  ToDoApp
  //
  //  Created by Jessy Viranaiken on 09/08/2024.
  //

import Foundation

extension Date {
  
  func combineDateAndHour(date: Date?, hour: Date?) -> Date? {
    guard let date = date else {
      return nil
    }
    if let hour = hour {
      let calendar = Calendar.current
      let hourComponents = calendar.dateComponents([.hour, .minute], from: hour)
      var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
      dateComponents.hour = hourComponents.hour
      dateComponents.minute = hourComponents.minute
      return calendar.date(from: dateComponents)
    } else {
      return date
    }
  }
  
  func formatDateToISO8601(date: Date?) -> String? {
    guard let date = date else {
      return nil
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.string(from: date)
  }
  
}
