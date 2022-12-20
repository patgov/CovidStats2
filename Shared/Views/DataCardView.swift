//
//  DataCardView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/15/22.
// A Card for World Totals that show name and number

import SwiftUI

struct DataCardView: View {

  var number: String = "--"
  var name: String = "Error"
  var color: Color = .secondary


  var body: some View {
      // Dynamic card size for different size devices
    GeometryReader {  geometry in

      VStack(spacing: 10) {
        Text(self.number)
          .font(.subheadline)
          .foregroundColor(self.color)

        Text(self.name)
          .font(.body)
          .foregroundColor(self.color)
      }
      .frame(width: geometry.size.width, height: 80, alignment: .center)
   //  .background(Color("cardBackground"))

     // .padding(5)
      //MARK: Test border
      .border(.orange)
      .cornerRadius(3)
    }



  }
}

struct DataCardView_Previews: PreviewProvider {
    static var previews: some View {
        DataCardView()
    }
}
