//
//  ConnectionInfo.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/26/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import Foundation

struct MyConnection {
    var user: String?
    var name: String
    var email: String
    var address: String
    var latitude: Double
    var longitude: Double
    var createdDate: Date?
    var lastMeetupDate: Date?
    var description: String
    var connectionPicture: Data
}
