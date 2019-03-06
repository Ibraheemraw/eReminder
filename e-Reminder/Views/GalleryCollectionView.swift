//
//  GalleryCollectionView.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 3/6/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView {
var gradient: CAGradientLayer!
    override func awakeFromNib() {
        super.awakeFromNib()
        addGradient()
    }
    func addGradient(){
        
        let softCyan = UIColor.init(red: 156/255, green: 236/255, blue: 251/255, alpha: 0.5)
        let softBlue = UIColor.init(red: 101/255, green: 199/255, blue: 247/255, alpha: 0.5)
        let strongBlue = UIColor.init(red: 0/255, green: 82/255, blue: 212/255, alpha: 0.5)
        gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [softCyan.cgColor, softBlue.cgColor, strongBlue.cgColor]
        self.layer.addSublayer(gradient)
    }
}
