//
//  SettingsView.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/18/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class SettingsView: UIView {
    //Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var connectionListPicker: UIPickerView!
    @IBOutlet weak var NotificationPicker: UIDatePicker!
    
    @IBOutlet weak var noticationBodyContent: UITextField!
    //Override Initalizers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    // Required Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    
    }
    //  helper method that bridges both initializers
    private func commonInit(){
        // load the nib file
        Bundle.main.loadNibNamed("SettingsView", owner: self, options: nil)
        //add the view
        addSubview(contentView)
        //
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

