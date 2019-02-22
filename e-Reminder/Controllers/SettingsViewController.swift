//
//  SettingsViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/13/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsViewController: UIViewController {
    //Outlets
    @IBOutlet var settingsView: SettingsView!
    //Overriding functions
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.connectionListPicker.delegate = self
       settingsView.NotificationPicker.addTarget(self, action: #selector(setupNotications), for: .valueChanged)
    }
    @objc func setupNotications() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.subtitle = "Notification Subtitle"
        content.body  = "This will be a description of the Notifcation"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notifcations temp"
        let dateComponent = Calendar.current.dateComponents([.year, .month,.day,.hour, .minute, .second], from: settingsView.NotificationPicker.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest.init(identifier: "content", content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
extension SettingsViewController: UIPickerViewDelegate {
    
}
