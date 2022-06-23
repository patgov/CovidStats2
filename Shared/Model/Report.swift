//
//  Report.swift
//  CovidStats
//
//  Created by Pat Govan on 6/14/22.
//

import Foundation

struct AllReports: Codable {
  let data: [RegionReport]
}

struct RegionReport: Codable,Identifiable {
  var id = UUID()
  let date: Date  // decode a string into a string
  let confirmed: Int
  let deaths: Int
  let active: Int
 // let recovered: Int
  let fatality_rate: Double
  let region: RegionDetail
  
// var the returns a string
  var formattedDate: String { date.formatted(date: .abbreviated, time: .omitted)
  }


  static let dummyData = RegionReport(date: Date.now, confirmed: 0, deaths: 0, active: 0, fatality_rate: 0.0, region: RegionDetail(name: "N/A", province: "province"))
  
}

struct RegionDetail: Codable {
  let name: String
  let province: String
}



//
//"data":[59 items
//        0:{12 items
//  "date":"2022-06-13"
//  "confirmed":1617208
//  "deaths":13056
//  "recovered":0
//  "confirmed_diff":6415
//  "deaths_diff":10
//  "recovered_diff":0
//  "last_update":"2022-06-14 04:20:52"
//  "active":1604152
//  "active_diff":6405

//"region":{6 items
//  "iso":"USA"
//  "name":"US"
//  "province":"Washington"
//  "lat":"47.4009"
//  "long":"-121.4905"
//  "cities":[...]40 items
//}
//}
