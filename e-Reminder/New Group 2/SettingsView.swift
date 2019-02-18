//
//  SettingsView.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/13/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class SettingsView: UIView {

    @IBOutlet var settingsView: SettingsView!
    @IBOutlet weak var connectionNamePicker: UIPickerView!
    
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    // coming from programmatic ui code
    override init(frame: CGRect) {
        //takes up the entire screen
        super.init(frame: UIScreen.main.bounds)
    }
    //'required' initializer 'init(coder:)' must be provided by subclass of 'UIView'
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        commonInit()
    }
    // bridging helper methods
    private func commonInit(){
        // load the nib/.xib file name "Name of NibFile", owner is the view itself, & options is nil
        Bundle.main.loadNibNamed("SettingsView", owner: self, options: nil)
        // Adding the subView
        addSubview(settingsView)
        // give the view a frame
        settingsView.frame = bounds
        //give the view an autoSizing Mask: - An integer bit mask that determines how the receiver resizes itself when its superview’s bounds change. When a view’s bounds change, that view automatically resizes its subviews according to each subview’s autoresizing mask. You specify the value of this mask by combining the constants described in UIView.AutoresizingMask using the C bitwise OR operator.
        settingsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    
}
