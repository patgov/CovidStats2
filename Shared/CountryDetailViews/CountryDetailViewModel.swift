//
//  CountryDetailView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.
//

import Foundation
import SwiftUI

// Country Detail View Model

final class CountryDetailViewModel: ObservableObject {

// publish return parameter for when RegionReport is updated
  @Published var reports: [RegionReport] = []
  @Published var alertItem: AlertItem?
  private var iso: String

  // Only fetch the data when the view has opened
  init(country: Country) {
    iso = country.iso
  
  }

  func fetchReport() {

    APIService.shared.fetchReport(for: iso) { result in

      DispatchQueue.main.async {
        switch result {

          case .success(let reports):
            self.reports = reports

          case .failure(_):
         print("Error getting country report")
            // MARK: Testing alertItem
      self.alertItem = AlertContext.unableToFetchCountryStats
             
        }
      }
    }
  }
}
