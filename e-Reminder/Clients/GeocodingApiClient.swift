//
//  GeocodingApiClient.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/26/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import Foundation

final class GeocodingApiClient {
    static func createLocations(userInput: String,  callBack: @escaping([Results]?,AppError?) -> Void){
        //create a constant for the endpoint
        let endPointStr = "https://maps.googleapis.com/maps/api/geocode/json?address=\(userInput)&key=\(PrivateInfoFile.GeocodingApiKey)"
        // create a url for the endpoint
        guard let url = URL.init(string: endPointStr) else {
            print("bad url: \(endPointStr)")
            return
        }
        //
        let request = URLRequest.init(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                callBack(nil, AppError.networkError(error))
            }
            guard let response = response as? HTTPURLResponse,(200...299).contains(response.statusCode) else {
                //callBack(nil, AppError.badStatusCode(<#T##String#>))
                print("Bad Status Code")
                return
            }
            if let data = data {
                do {
                    let geocodingResults = try JSONDecoder().decode(GeocodingModel.self, from: data)
                    let results = geocodingResults.results
                    callBack(results, nil)
                } catch {
                    callBack(nil, AppError.jsonDecodingError(error))
                }
            }
        }
       task.resume()
    }
}
