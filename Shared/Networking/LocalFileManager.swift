//
//  LocalFileManager.swift
//  CovidStats
//
//  Created by Pat Govan on 6/21/22.
//
// save data locally and save back data locally
// Save the json from an api to a local directory
// Before requesting the API for more data, check the local file manager if it already exists,  get the data locally, otherwise request the API for the data.


import Foundation



final class LocalFileManager {

  static let shared = LocalFileManager()

  private init () { }

    // Pass Data from API
  func saveCountriesLocally(countryData: Data?) {

    if let countryData = countryData {
        // Convert to JSON as  dictionary[ ] with Any value
      if let json = try? JSONSerialization.jsonObject(with: countryData, options: []) as? [String:Any]
      {

        // MARK: local json data test
     //print(json)
      do {
          // get the file for writing data - rw country.json
        let fileURL = getDocumentDirectory().appendingPathComponent("country.json")
          // try to save it to that file
        try JSONSerialization.data(withJSONObject: json).write(to: fileURL)

      } catch {
        print(error.localizedDescription)
      }
      }
    }
  }

    // get the data back from country.json
  func fetchLocalCountries() -> Data? {

    do {
      let fileURL = getDocumentDirectory().appendingPathComponent("country.json")

      let data = try Data(contentsOf: fileURL)
      return data

    } catch {
      print(error.localizedDescription)
        // if nothing is saved, return nil
      return nil
    }
  }

    // file storage provided by iOS
  private func getDocumentDirectory() -> URL {
    FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

  }


} // End of Class
