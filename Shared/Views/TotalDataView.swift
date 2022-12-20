//
//  TotalDataView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/15/22.
//

import SwiftUI

struct TotalDataView: View {

  // showing the TotalData
  var totalData: TotalData

    var body: some View {
      VStack{
        HStack {
          // format number into a string
         // DataCardView(number: totalData.confirmed.formatNumber, name: "Confirmed")
          
          DataCardView(number: totalData.confirmed.formatNumber, name: "Confirmed")
          DataCardView(number: totalData.active.formatNumber, name: "Active", color: .green)
        }

        HStack {
          DataCardView(number: totalData.deaths.formatNumber, name: "Deaths", color: .red)
          // format decimal
          DataCardView(number:  String(format: "%.2f", totalData.fatality_rate), name: "Death %", color: .red)
        }
      }
      .frame(height: 170)
// MARK: Test padding
        // .padding(5)
        // MARK: Border Test
      .border(.black)

    }
}

struct TotalDataView_Previews: PreviewProvider {
    static var previews: some View {
      TotalDataView(totalData: .dummyData)
    }
}
