//
//  AlertItem.swift
//  CovidStats
//
//  Created by Pat Govan on 6/21/22.
//

 import Foundation
import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: Text
  let message: Text
  let dismissButton: Alert.Button
}

struct AlertContext {

  static let unableToFetchTotalStats = AlertItem(title: Text("Error World Total"),
                                                 message: Text("Server doesn't respond. \n Please try again later!"),
                                                 dismissButton: .default(Text("OK")))

  static let unableToFetchCountryStats = AlertItem(title: Text("Error Country Data"),
                                                 message: Text("Unable to receive data from the server. \n Please try again later!"),
                                                 dismissButton: .default(Text("OK")))

  static let unableToFetchCountries = AlertItem(title: Text("Error World Total"),
                                                message: Text("Unable to fetch list of countries. \n Please try again later!"),
                                                dismissButton: .default(Text("OK")))

}
