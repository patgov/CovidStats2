//
//  MainViewModel.swift
//  CovidStats
//
//  Created by Pat Govan on 6/15/22.
// fetch all the countries

import Foundation
import SwiftUI


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

  // MARK: func fetchTotalData()
  func fetchTotalData() {
    APIService.shared.fetchTotalData { result in

      //main thread
        DispatchQueue.main.async {
            switch result {
            case .success(let totalData):
                self.totalData = totalData
            case .failure(_):
                self.alertItem = AlertContext.unableToFetchTotalStats
                
            }
        }
    }
  }

  // MARK: func fetchAllCountries()
  func fetchAllCountries() {
    APIService.shared.fetchAllRegions { result in
        // main thread
      DispatchQueue.main.async {
        switch result {
          case .success(let allCountries):
              // sort alphabetically
            self.allCountries = allCountries.sorted(by: { $0.name < $1.name } )
     
          case .failure(_):
            self.alertItem = AlertContext.unableToFetchCountries
        }
      }
    }
  }
}
