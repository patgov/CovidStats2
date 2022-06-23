//
//  TotalDataView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/15/22.
//

import SwiftUI

struct TotalDataView: View {

  var totalData: TotalData

    var body: some View {
      VStack{
        HStack {
       DataCardView(number: totalData.confirmed.formatNumber, name: "Confirmed")
       DataCardView(number: totalData.active.formatNumber, name: "Active", color: .green)
        }

        HStack {
        DataCardView(number: totalData.deaths.formatNumber, name: "Deaths", color: .red)
     DataCardView(number:  String(format: "%.2f", totalData.fatality_rate), name: "Death %", color: .red)
        }
      }
      .frame(height: 170)
      .padding(5)


    }
}

struct TotalDataView_Previews: PreviewProvider {
    static var previews: some View {
      TotalDataView(totalData: .dummyData)
    }
}
