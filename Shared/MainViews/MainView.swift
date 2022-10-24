// MainView.swift
//  Shared
//
//  Created by Pat Govan on 6/14/22.

import SwiftUI

struct MainView: View {
// initializing MainViewModel
   @StateObject private var viewModel = MainViewModel()

 @State var path: [Country] = []

  var body: some View {


    if #available(iOS 16.0, *) {
      NavigationStack(path:$path) {

        ZStack(alignment: .top) {

          LinearGradient(colors: [
            Color(red: 0.76, green: 0.15, blue: 0.26),
            Color(red: 0.01, green: 0.23, blue: 0.5)
          ], startPoint: .topLeading, endPoint: .bottomTrailing  )
          .ignoresSafeArea()

          VStack (alignment: .leading) {
            Text("World Totals")
              .font(.title2)
              .foregroundColor(.white)
              .padding(10)


              // TODO:  needs to be changed to local data
            TotalDataView(totalData: viewModel.totalData)

              // conditional search field visibility
            if viewModel.isSearchVisible {
              SearchBarView(searchText: $viewModel.searchText)
            }

              ///All Countries  v7
            Text("All Countries")
              .font(.title2.bold())
              .foregroundColor(.white)
              .padding(10)


              // List all Countries
            List {
              Section {
                  // go over all the countries in viewModel
                ForEach(viewModel.allCountries.filter {
                    // show the search results with search results
                  viewModel.searchText.isEmpty ? true : $0.name.lowercased().contains(viewModel.searchText.lowercased())
                }, id:\.iso) { country in
                  HStack {
                    Text("\(country.name)  -")
                   // NavigationLink(country.name, value: country)
                    NavigationLink(country.iso, value: country)
                  }
                }
                }
              }
            .listStyle(.plain)

            } // End of List
          // modifier (for: Type of data) navigationDestination is tracks
            .navigationDestination(for: Country.self ) { country in
              //The modifier takes a view builder that describes what view is to be pushed onto the stack when a value is presented
              CountryDetailView(viewModel: CountryDetailViewModel(country: country))
          }
          .padding()
        }
        .navigationTitle("Statistics")

          // Alert
        .alert(item: $viewModel.alertItem, content: { alertItem in
          Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        })

          // MARK: ToolBar search image
        .toolbar {
          Button {
              // enable search view
            viewModel.isSearchVisible.toggle()
              // set search to empty view before typing search country
            if !viewModel.isSearchVisible {
                //text search empty string
              viewModel.searchText = ""
            }
          } label: {
            Image(systemName: "magnifyingglass")

          }
        }
        .tint(.white)

      } // End of NavigationView
      .accentColor(.white)
    } else {
        // Fallback on earlier versions
    }

   //Goto another view

    }
  }


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

