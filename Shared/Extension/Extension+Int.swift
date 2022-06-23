//
//  Extension+Int.swift
//  CovidStats
//
//  Created by Pat Govan on 6/15/22.
// Format numbers

import Foundation
// Convert Int to String
extension Int {
  var formatNumber: String {
    // func formatNumber() -> String {
    let formatter = NumberFormatter()
    formatter.groupingSeparator = ","
    formatter.numberStyle = .decimal
    return formatter.string(from: NSNumber(value: self))!

  }

  var roundedWithAbbreviation: String {
    let number = Double(self)
    let million = number / 1_000_000

    if million >= 1.0 {
      return "\(round(million*10)/10)M"
    } else {
      return "\(self.formatNumber)"

    }
  }
}



