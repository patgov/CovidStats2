//
//  File.swift
//  CovidStats
//
//  Created by Pat Govan on 6/14/22.



  // API SERVICE

import Foundation

// all api interacts with this class
// From the API get the totals regions and report
/*
 "X-RapidAPI-Key": "cbb8cd2732msh0977d692947162bp1bdea7jsnf4b4e3165ccd",
 "X-RapidAPI-Host": "covid-19-statistics.p.rapidapi.com"
 */

class APIService {

  //instance of APIService

  static let shared = APIService()

  // Prevent initializing from outside of class
  private init () {}

  private  let headers = [
    "X-RapidAPI-Key": "cbb8cd2732msh0977d692947162bp1bdea7jsnf4b4e3165ccd",
    "X-RapidAPI-Host": "covid-19-statistics.p.rapidapi.com"
  ]

  private let URLString = "https://covid-19-statistics.p.rapidapi.com"

  // create callback for when the data is ready from the server as a total data report
  // totalData is an object to convert the api

// MARK: fetchTotalData
  func fetchTotalData(completion: @escaping(Result<TotalData, Error>)-> Void) {

    let totalURL = URLString + "/reports/total"

  let url = URL(string: totalURL)

    // if no url show error incorrectURL
  guard let url = url else {
      // call the completion handler
   completion(.failure(CovidError.incorrectURL))
      //then exit function
      return
    }
      //If a url then request data from the url
      var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,  timeoutInterval: 10.0)
   //   let httpResponse = response as? HTTPURLResponse

      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers

      let session = URLSession.shared

      let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

        if (error != nil) {
          //use completion handler again or use error
          completion(.failure(CovidError.noDataReceived))
        } else {
            // create json object and receive data object and convert to json
          //Testing
 //           if let json = try? JSONSerialization.jsonObject(with: data!, options: [])
 //           as? [String: Any] {
//             print(json)
//            }

          // Convert TotalData to a data object
          let decoder = JSONDecoder()
            // TotalDataObject is the  is the Object of TotalData: TotalData are the item in the totalDataObject ["data": { .... }]
          // Make TotalDataObject accept TotalData
          do {
            let totalDataObject = try decoder.decode(TotalDataObject.self, from: data!)
            completion(.success(totalDataObject.data))
          } catch let error {
            completion(.failure(error))
          }
        }
      })
    
      // urls request will not start without /.resume()
        dataTask.resume()
      }

// MARK:  func fetchAllRegions (completion: @escaping(Result<[Country], Error>)-> Void)
  
  func fetchAllRegions (completion: @escaping(Result<[Country], Error>)-> Void) {
    // decode data in local database
  //  let decoder = JSONDecoder()
      ///Check if local data is available,and if there is data, convert the data to allCountries data, if there is local data use that data.
  //  if LocalFileManager.shared.fetchLocalCountries() != nil {

   let countriesURL = URLString + "/regions"

   let url = URL(string: countriesURL)

      // if no url show error incorrectURL
    guard let url = url else {
       //  call the completion handler
      completion(.failure(CovidError.incorrectURL))
      //  then exit function
      return
    }
      
      // If a url then request data from the url
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,  timeoutInterval: 10.0)

    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared

    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

      if (error != nil) {
          //use completion handler again or use error
        completion(.failure(CovidError.noDataReceived))
      } else {
       let decoder = JSONDecoder()

          // TODO: Text from api - works
          //  if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
          // print(json)
          //  }


        // TotalDataObject is the is the Object of TotalData: TotalData are the item in the totalDataObject ["data": { .... }]
        // Save the data locally to country.json The data will save the first time
        LocalFileManager.shared.saveCountriesLocally(countryData: data)
        do {
          let allCountries = try decoder.decode(AllRegions.self, from: data!)
          completion(.success(allCountries.data))
        } catch let error {
          completion(.failure(error))
        }
      }
    })
      // urls request will not start without /resume
    dataTask.resume()
  }



// MARK: func fetchReport(for iso object: String, completion: @escape(Result< [RegionReport], Error>) -> Void ){ ... }

  func fetchReport(for iso: String, completion: @escaping(Result<[RegionReport], Error>)-> Void) {

    let reportsURL = URLString + "/reports?iso=\(iso)"

    let url = URL(string: reportsURL)

      // if no url show error incorrectURL
    guard let url = url else {
        // call the completion handler
      completion(.failure(CovidError.incorrectURL))
        //then exit function
      return
    }
      //If a url then request data from the url
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,  timeoutInterval: 10.0)

    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared

    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

      if (error != nil) {
          //use completion handler again or use error
        completion(.failure(CovidError.noDataReceived))
      } else {

        let decoder = JSONDecoder()

          //    TODO: Text from api  Not working
      // if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: //Any] {
        // print(json)
        // }

        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

      do {
          let allReports = try decoder.decode(AllReports.self, from: data!)
          completion(.success(allReports.data))
        } catch let error {
          completion(.failure(error))
        }
      }
    })
    dataTask.resume()
  }
}

