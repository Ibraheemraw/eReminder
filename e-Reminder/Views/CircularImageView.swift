//
//  CircularImageView.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/27/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
@IBDesignable // Utiltiy for interface builder - storyBoard
class CircularImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = bounds.width / 2.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
    }
}
