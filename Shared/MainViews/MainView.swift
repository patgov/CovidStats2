//
// MainView.swift
//  Shared
//
//  Created by Pat Govan on 6/14/22.
//

import SwiftUI

struct MainView: View {
// initializing MainViewModel
   @StateObject private var viewModel = MainViewModel()

  var body: some View {

    NavigationView {
      ZStack(alignment: .top) {

        LinearGradient(colors: [
          Color(red: 0.76, green: 0.15, blue: 0.26),
          Color(red: 0.01, green: 0.23, blue: 0.5)
        ], startPoint: .topLeading, endPoint: .bottomTrailing  )
        .ignoresSafeArea()

       VStack (alignment: .leading){
          Text("World Total")
            .font(.title2)
            .foregroundColor(.white)
            .padding()

     TotalDataView(totalData: viewModel.totalData)

         if viewModel.isSearchVisible {
         SearchBarView(searchText: $viewModel.searchText)
         }

          Text("All Countries")
            .font(.title2.bold())
            .foregroundColor(.white)
            .padding(5)

          List {
            Section {

                // Show all countries
              ForEach(viewModel.allCountries.filter {
                viewModel.searchText.isEmpty ? true :
                
                  //check name with contains with search
                $0.name.lowercased().contains(viewModel.searchText.lowercased())
              }, id: \.iso) { country in

                  // Navigation to detail view of each country
                // Initialize the CountryDetailViewModel with country
                //1550 11
                NavigationLink(destination: CountryDetailView(viewModel: CountryDetailViewModel(country: country))) {
                  Text(country.name)
                }
              }
            }
          }
          .listStyle(.plain)

        }
      }
      .navigationTitle("Statistics")

      // Alert
      .alert(item: $viewModel.alertItem, content: { alertItem in
        Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
      })
      .toolbar {

        
        Button {
          viewModel.isSearchVisible.toggle()
          if !viewModel.isSearchVisible {

            viewModel.searchText = ""
          }
        } label: {
          Image(systemName: "magnifyingglass")

        }
      }
      .tint(.white)
    }
    .accentColor(.primary)

  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

