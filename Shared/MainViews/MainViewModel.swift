//
//  MainViewModel.swift
//  CovidStats
//
//  Created by Pat Govan on 6/15/22.
// fetch all the countries

import Foundation

// fetch all the world total data

final class MainViewModel: ObservableObject {

 @Published var totalData = TotalData.dummyData
  @Published var allCountries: [Country] = []
  @Published var searchText = ""
  @Published var isSearchVisible = false
  @Published var alertItem: AlertItem?


  init() {
    fetchTotalData()
    fetchAllCountries()
  }

  func fetchTotalData() {
    APIService.shared.fetchTotalData { result in
      DispatchQueue.main.async {
        switch result {
          case .success(let totalData):
            self.totalData = totalData
          case .failure(_):
              // print("Error total data")
            self.alertItem = AlertContext.unableToFetchTotalStats

        }
      }
    }
  }

  func fetchAllCountries() {
    APIService.shared.fetchAllRegions { result in
        // Put it on the main thread
      DispatchQueue.main.async {
        switch result {
          case .success(let allCountries):
              // sort alphabetically
            self.allCountries = allCountries.sorted(by: { $0.name < $1.name } )
          case .failure(_):
              //print("Error total data")
            self.alertItem = AlertContext.unableToFetchCountries

        }
      }
    }
  }
}
