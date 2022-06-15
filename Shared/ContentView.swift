//
//  ContentView.swift
//  Shared
//
//  Created by Pat Govan on 6/14/22.
//

import SwiftUI

struct ContentView: View {

  var body: some View {
    Text("Hello, world!")
      .padding()
      .onAppear {

        APIService.shared.fetchReport(for: "BGR") { result in
          switch result {
           case.success(let region):
              print(region.count)
            print(region.first!.formattedDate)
           case .failure(let error):
          print(error.localizedDescription)
              
          }
        }
      }

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}


//Test all countries
  // case .success(let allCountries):
  // print(allCountries.confirmed)
  //result = 535743452
//print(allCountries.count)

  //   APIService.shared.fetchTotalData { result in
  //Testing country regions
  //        APIService.shared.fetchAllRegions { result in
  //          switch result {
// case .success(let totalData):
