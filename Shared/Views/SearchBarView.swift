//
//  SearchBarView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.
//

import SwiftUI

struct SearchBarView: View {
  @Binding var searchText: String

    var body: some View {
      HStack {
        TextField("Country...", text: $searchText)
          .foregroundColor(.white)
          .padding()

      }
      .frame(height: 40)
      // somewhat translucent
      .background(.regularMaterial)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
      // How do you know this is constant
      SearchBarView(searchText: .constant(""))
    }
}