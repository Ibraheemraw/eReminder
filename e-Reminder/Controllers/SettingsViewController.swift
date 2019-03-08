//
//  SettingsViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/13/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData
class SettingsViewController: UIViewController {
    //MARK: - Configuration Outlets
    @IBOutlet var settingsView: SettingsView!
    //MARK: - Configuration Properties
    private var container = AppDelegate.container // container from AppDelegate
    private var names = [Connection]()
    private var notificationName: String?
    private var bodyText: String?
    //MARK: - Configuration Overriding Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.connectionListPicker.delegate = self
        settingsView.connectionListPicker.dataSource = self
        settingsView.noticationBodyContent.delegate = self
       settingsView.NotificationPicker.addTarget(self, action: #selector(setupNotications), for: .valueChanged)
        getCoreDataInfo()
        settingsView.NotificationPicker.isEnabled = false
    }
    func getCoreDataInfo(){
        if let context = container?.viewContext {
            let request: NSFetchRequest<Connection> = Connection.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
            for name in names {
               request.predicate = NSPredicate.init(format: "name = %@", name.name ?? "name is nil")
            }
            do  {
                let names = try context.fetch(request)
                self.names = names
            } catch {
                print(error)
            }
        }
    }
    
    @objc func setupNotications() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Custom Follow UP!"
        content.subtitle = "Time to follow up with \(notificationName ?? "subtitle is nil")"
        content.body  = "\(bodyText ?? "body is nil")"
        content.sound = UNNotificationSound.default
        content.threadIdentifier = "local-notifcations temp"
        let dateComponent = Calendar.current.dateComponents([.year, .month,.day,.hour, .minute, .second, .second, .nanosecond], from: settingsView.NotificationPicker.date)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest.init(identifier: "content", content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
      notificationName = names[row].name
    }
}
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let bodyText = textField.text else {
            fatalError("Your bodyText constant is nil")
        }
        self.bodyText = bodyText
        if !bodyText.isEmpty {
            settingsView.NotificationPicker.isEnabled = true
        }
        print("The user's input: \(String(describing: self.bodyText))")
       return textField.resignFirstResponder()
    }
}
