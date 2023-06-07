//
//  SearchBarView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.


import SwiftUI

struct SearchBarView: View {
  @Binding var searchText: String

    var body: some View {
      HStack {
          // create a binding string $searchText
        TextField("Country...", text: $searchText)
        //MARK: Text color 
          .foregroundColor(.black)
          .padding(2)

      }
      .frame(height: 50)
      // somewhat translucent
      .background(.regularMaterial)
      // MARK: Test border
      .border(.black)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
      // use constant for a binding sting
      SearchBarView(searchText: .constant(""))
    }
}
