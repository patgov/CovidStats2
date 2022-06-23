//
//  CountryDetailView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.
//

import Foundation

final class CountryDetailViewModel: ObservableObject {

// every time published, RegionReport  is updated
  @Published var reports: [RegionReport] = []
  @Published var alertItem: AlertItem?

  private var iso: String

  // Only fetch the data when the view has opened
  init(country: Country) {
    iso = country.iso

  }

  func fetchReport() {

    APIService.shared.fetchReport(for: iso ) { result in

      DispatchQueue.main.async {
        switch result {
            // lets reports var name
          case .success(let reports):
            self.reports = reports
          case .failure(_):
           // print("Error getting country report")'
            self.alertItem = AlertContext.unableToFetchCountryStats
             
        }
      }
    }
  }
}
