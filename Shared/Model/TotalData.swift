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

}



//"data":{11 items
//  "date":"2022-06-13"
//  "last_update":"2022-06-14 04:20:52"
//  "confirmed":535743452
//  "confirmed_diff":485602
//  "deaths":6310422
//  "deaths_diff":997
//  "recovered":0
//  "recovered_diff":0
//  "active":529433030
//  "active_diff":484605
//  "fatality_rate":0.0118
//}
