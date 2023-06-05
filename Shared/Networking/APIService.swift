//
//  File.swift
//  CovidStats
// https://rapidapi.com/axisbits-axisbits-default/api/covid-19-statistics/
//  Created by Pat Govan on 6/14/22.
// API SERVICE


import Foundation

// all api interacts with this class
// From the API get the totals regions and report

class APIService {

  static let shared = APIService()


  private init () {}
    //bc8d714225msh8661833d4760903p17f9a8jsn41e8b34682b9
  private  let headers = [

    "X-RapidAPI-Key": "bc8d714225msh8661833d4760903p17f9a8jsn41e8b34682b9",
    "X-RapidAPI-Host": "covid-19-statistics.p.rapidapi.com"
  ]

  private let URLString = "https://covid-19-statistics.p.rapidapi.com"

  // create callback for when the data is ready from the server as a total data report
  // totalData is an object to convert the api

// MARK: func fetchTotalData(completion: @escaping(Result<TotalData, Error>)-> Void)
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


      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers

      let session = URLSession.shared

      let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

        if (error != nil) {

          completion(.failure(CovidError.noDataReceived))
          return
        } else {
        // create json object and receive data object and convert to json
          //Testing json
           if let json = try? JSONSerialization.jsonObject(with: data!, options: [])
           as? [String: Any] {
           print(json)
           }

          // Convert TotalData to a data object
          let decoder = JSONDecoder()

          do {
            let totalDataObject = try decoder.decode(TotalDataObject.self, from: data!)
            completion(.success(totalDataObject.data))
          } catch let error {
            completion(.failure(error))
              // TODO: debugPrint
          //    debugPrint("Error loading \(url): \(String(describing: error))")
          }

        }
      })
        dataTask.resume()
      }

// MARK:  func fetchAllRegions (completion: @escaping(Result<[Country], Error>)-> Void)
  
  func fetchAllRegions (completion: @escaping(Result<[Country], Error>)-> Void) {
    //  Data in local database
  let decoder = JSONDecoder()
      // Check if local data is available,and if there is data, convert the data to allCountries data, if there is local data use that data.
  if let data = LocalFileManager.shared.fetchLocalCountries() {
    do {
   print("returning from local data!")
      let allCountries = try decoder.decode(AllRegions.self, from: data)
      completion(.success(allCountries.data))
    } catch let error {
      completion(.failure(error))
    }
    return
  }
   let countriesURL = URLString + "/regions"

   let url = URL(string: countriesURL)

    guard let url = url else {
       // call the completion handler
      completion(.failure(CovidError.incorrectURL))
      // then exit function
      return
    }
      // If url is present, then request data from the url
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,  timeoutInterval: 10.0)

    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared

    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

      if (error != nil) {
          //use completion handler again or use error
        completion(.failure(CovidError.noDataReceived))
      } else {

          //TODO: Test fetch json func fetchAllRegions
//           if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//           print(json)
//           }

        // Save the data locally to country.json for the first time. Once saved, the country.json is available for the duration while the app is running.
          
          LocalFileManager.shared.saveCountriesLocally(countryData: data)
        do {
//MARK: Test print
          print("returning from API")
          
          let allCountries = try decoder.decode(AllRegions.self, from: data!)
          completion(.success(allCountries.data))

        } catch let error {
          completion(.failure(error))
        }
      }
    })

    dataTask.resume()
  }

// MARK: func fetchReport(for iso object: String, completion: @escape(Result< [RegionReport], Error>) -> Void ){ ... }

  func fetchReport(for iso: String, completion: @escaping(Result<[RegionReport], Error>)-> Void) {

      // MARK: Reports  iso=  "CAN

    let reportsURL = URLString + "/reports?iso=\(iso)"
      //reports?iso=CAN"
      //=\(iso)
    let url = URL(string: reportsURL)

      // if no url show error incorrectURL

    guard let url = url else {
        // call the completion handler
      completion(.failure(CovidError.incorrectURL))
        //If a url then request data from the url
      return
    }
    var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy,  timeoutInterval: 10.0)

    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers

    let session = URLSession.shared

    let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in

      if (error != nil) {

          // use completion handler again or use error
        completion(.failure(CovidError.noDataReceived))
      } else {

        let decoder = JSONDecoder()

// MARK: Test From API, This is working
// if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
// print(json)
// }

        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

      do {
        //MARK: Test From API, all data, This is working
       //  print("returning from API")

          let allReports = try decoder.decode(AllReports.self, from: data!)
          completion(.success(allReports.data))

     debugPrint(allReports.data as Any)
        } catch let error {
          completion(.failure(error))
        }
      }
    })
    dataTask.resume()
  }
}

