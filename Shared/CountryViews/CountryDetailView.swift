//
//  CountryDetailView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.
//

import SwiftUI

struct CountryDetailView: View {


    // observe CountryDetailViewModel
  @ObservedObject var  viewModel: CountryDetailViewModel

  var body: some View {

    VStack {
        // checking if there is a province
      if viewModel.reports.count > 1 {
          // show list if there are more items
        List {
            // id not included - RegionReports has uuid - report is RegionReports
          ForEach(viewModel.reports) { report in

              // link to name of province or state
            NavigationLink(destination: ReportView(report: report)) {
              // Show the province
              Text(report.region.province )
            }
          }
        }
        // There could be a list of provinces or a detail view of country
        .listStyle(.plain)
        // if nil, Unknown Country
        .navigationTitle(viewModel.reports.first?.region.name ?? "Unknown Country")
        .navigationBarTitleDisplayMode(.inline)
      } else {
        // show report
        ReportView(report: viewModel.reports.first ?? RegionReport.dummyData)
          .ignoresSafeArea()
      }
    }

      // Alert
    .alert(item: $viewModel.alertItem, content: { alertItem in
      Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
    })

      // If viewModel fetches the report,  otherwise there isn't a need to go back to fetchReport again. Go back only if there isn't a report.
    .onAppear {
      if viewModel.reports.count == 0 {
        viewModel.fetchReport()
      }
    }
    
  }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
      // how do you know this  preview code
      CountryDetailView(viewModel: CountryDetailViewModel(country: Country.dummyData))
    }
}
