#  Covid Statistics from all Countries and the USA State

`import Foundation

let headers = [
	"X-RapidAPI-Key": "cbb8cd2732msh0977d692947162bp1bdea7jsnf4b4e3165ccd",
	"X-RapidAPI-Host": "covid-19-statistics.p.rapidapi.com"
]

let request = NSMutableURLRequest(url: NSURL(string: "https://covid-19-statistics.p.rapidapi.com/reports?city_name=Autauga&region_province=Alabama&iso=USA&region_name=US&q=US%20Alabama&date=2020-04-16")! as URL, cachePolicy: .useProtocolCachePolicy,  timeoutInterval: 10.0)
request.httpMethod = "GET"
request.allHTTPHeaderFields = headers

let session = URLSession.shared
let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
	if (error != nil) {
		print(error)
	} else {
		let httpResponse = response as? HTTPURLResponse
		print(httpResponse)
	}
})

dataTask.resume() `


* Used for testing
`
 .onAppear {

        APIService.shared.fetchReport(for: "BGR") { result in
          switch result {
           case.success(let region):
              print(region.count)
            print(region.first!.formattedDate)
           case .failure(let error):
          print(error.localizedDescription)

          }
        }
      }
      `

//Test allCountires

  // case .success(let allCountries):
  // print(allCountries.confirmed)

//print(allCountries.count)

  //   APIService.shared.fetchTotalData { result in
  //Testing country regions
  //        APIService.shared.fetchAllRegions { result in
  //          switch result {
// case .success(let totalData):
