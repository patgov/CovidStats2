//
//  TotalData.swift
//  CovidStats
//
//  Created by Pat Govan on 6/14/22.
//

import Foundation

// decode from top level of json data
struct TotalDataObject: Codable {
  let data: TotalData
}


struct TotalData: Codable {
  let confirmed: Int
  let deaths: Int
  let active: Int
  let recovered: Int
  let fatality_rate: Double

  static let dummyData = TotalData(confirmed: 0, deaths: 0, active: 0, recovered: 0, fatality_rate: 0.0 )

}

