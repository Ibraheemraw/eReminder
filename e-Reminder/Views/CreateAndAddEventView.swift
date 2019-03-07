//
//  CreateAndAddEventView.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 3/7/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import FaveButton

class CreateAndAddEventView: UIView {
    //Outlets
    @IBOutlet weak var goBackToViewBttn: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var eventBttn: FaveButton!
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit(){
        Bundle.main.loadNibNamed("CreateAndAddEventView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupFavButton()
    }
    private func setupFavButton(){
        self.eventBttn.setSelected(selected: false, animated: false)
        self.eventBttn.selectedColor = .orange
        
    }
}
