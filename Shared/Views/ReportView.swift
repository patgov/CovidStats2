//
//  ReportView.swift
//  CovidStats
//
//  Created by Pat Govan on 6/20/22.




import SwiftUI

struct ReportView: View {

  var report: RegionReport

  var body: some View {

    ZStack(alignment: .top) {

//LinearGradient(colors: [
    //  Color(red: 0.76, green: 0.15, blue: 0.26),
   //  Color(red: 0.01, green: 0.23, blue: 0.5)
   //   ], startPoint: .topLeading, endPoint: .bottomTrailing  )
   //   .ignoresSafeArea()

      VStack {

        Spacer()
          // Names of country and province
        Text(report.region.name)
        // MARK: Test color
          .foregroundColor(.gray)
          .font(.largeTitle)

        Text(report.region.province)
          // MARK: Test color
          .foregroundColor(.gray)
          .font(.title)

        Spacer()

          // Card Data
        VStack(alignment: .leading, spacing: 15) {
          Text("Date: \(report.formattedDate)")
          Text("Confirmed: \(report.confirmed.roundedWithAbbreviation)")
          Text("Active Cases: \(report.active.roundedWithAbbreviation)")
          Text("Deaths: \(report.deaths.roundedWithAbbreviation)")
          Text("Fatality Rate: \(report.fatality_rate.formatted())%")
        }
        .font(.title)
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(4)
// MARK: Test border
        .border(.blue)
        
        Spacer()
        Spacer()

      }
    }
      // MARK: Test border
    .border(.black)
    
  }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
      ReportView(report: RegionReport.dummyData)
    }
}
