//
//  SettingsViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/13/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var settingsView: SettingsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsView.connectionNamePicker.delegate = self
    }
    
}

extension SettingsViewController: UIPickerViewDelegate {
    
}
