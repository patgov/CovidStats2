//
//  ReportView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.
//

import SwiftUI

struct ReportView: View {

  var report: RegionReport

  var body: some View {

    ZStack(alignment: .top) {

      LinearGradient(colors: [
        Color(red: 0.76, green: 0.15, blue: 0.26),
        Color(red: 0.01, green: 0.23, blue: 0.5)
      ], startPoint: .topLeading, endPoint: .bottomTrailing  )
      .ignoresSafeArea()

      VStack {

        Spacer()
          // Names of country and province
        Text(report.region.name)
          .foregroundColor(.white)
          .font(.largeTitle)
   
        Text(report.region.province)
          .foregroundColor(.white)
          .font(.title)

        Spacer()

          // Card Data
        VStack(alignment: .leading, spacing: 15) {
          Text("Date: \(report.formattedDate)")
          Text("Confirmed: \(report.confirmed.roundedWithAbbreviation)")
          Text("Active: \(report.active.roundedWithAbbreviation)")
          Text("Deaths: \(report.deaths.roundedWithAbbreviation)")
          Text("Fatality Rate: \(report.fatality_rate.formatted())%")
        }
        .font(.title2)
        .frame(maxWidth: .infinity)
        .padding(50)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding()

        Spacer()
        Spacer()

      }
    }


    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
      ReportView(report: RegionReport.dummyData)
    }
}
