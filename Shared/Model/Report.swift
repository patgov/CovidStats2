//
//  Report.swift
//  CovidStats
//
//  Created by Pat Govan on 6/14/22.
// use with countryDetailView and CountryDetailViewModel

import Foundation

struct AllReports: Codable {
  let data: [RegionReport]
}

struct RegionReport: Codable,Identifiable, Hashable {
let id = UUID()
  let date: Date  // decode a string into a string
  let confirmed: Int
  let deaths: Int
  let active: Int
  let fatality_rate: Double
  let region: RegionDetail
 // let region: region_province
// var the returns a string
  var formattedDate: String { date.formatted(date: .abbreviated, time: .omitted)
  }


  static let dummyData = RegionReport( date: Date.now, confirmed: 0, deaths: 0, active: 0, fatality_rate: 0.0, region: RegionDetail(name: "N/A", province: "province"))
  
}

struct RegionDetail: Codable,Hashable {
  let name: String
  let province: String
}
