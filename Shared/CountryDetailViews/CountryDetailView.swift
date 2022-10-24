//
//  CountryDetailView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.


  // shows the report, AllReports, for countries and regionsDetails
  // create transition from main view to countryDetailView
import SwiftUI
// Transition from main view to country detail view
struct CountryDetailView: View {

    // observe CountryDetailViewModel
  @ObservedObject var  viewModel: CountryDetailViewModel

  var body: some View {

    VStack {
        // checking if there is a province
    if viewModel.reports.count > 1 {
          // show a new  list if there is more than one item, show list of provinces
        List {
          ForEach(viewModel.reports) { report in

/// NavigationLink<Text, CountryDetailView>>: the ID TWN occurs multiple times within the collection, this will give undefined results!

            NavigationLink(destination: ReportView(report: report)) {
                // Show the province from the report regions
              Text(report.region.province)

            }
          }

        }
        // There can be a list of provinces or a detail view of country
        .listStyle(.plain)

        // if nil, Unknown Country
    .navigationTitle(viewModel.reports.first?.region.name ?? "Unknown Country")
   .navigationBarTitleDisplayMode(.inline)
      
      } else {

        // initialize with report 
    ReportView(report: viewModel.reports.first ?? RegionReport.dummyData)
         .ignoresSafeArea()
   }
  }
      // Show Alert
    .alert(item: $viewModel.alertItem, content: { alertItem in
      Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
   })

      // onAppear if viewModel fetches the report, otherwise there isn't a need to go back to fetchReport again. Go back only if there isn't a report.

    .onAppear {
      if viewModel.reports.count == 0 {
     // Preview extra calls to API aren't needed when fetching the report.
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
