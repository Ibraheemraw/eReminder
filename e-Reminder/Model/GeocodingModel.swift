//
//  GeocodingModel.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/26/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import Foundation

struct GeocodingModel: Codable {
    let results: [Results]
}
struct Results: Codable {
    let formatted_address: String
    let geometry: GeometryContainer
}
struct GeometryContainer: Codable {
    let location: LocationContainer
}
struct LocationContainer: Codable {
    let lat: Double
    let lng: Double
}
