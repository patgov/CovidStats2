//
//  Region.swift
//  CovidStats
//
//  Created by Pat Govan on 6/14/22.
//

import Foundation

struct AllRegions: Codable
{
  let data: [Country]

}

struct Country: Codable, Hashable {
  let iso: String
  let name: String
  
  static let dummyData = Country(iso: "N/A", name: "Error")

}
