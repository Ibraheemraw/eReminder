//
//  ConnectionsListTableViewCell.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 3/1/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class ConnectionsListTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var connectionImage: CircularImageView!
    //Properties
    var gradient: CAGradientLayer!

    private var iExpectAConnectionBack: MyConnection!{
        didSet{
            updateUI()
        }
    }
    //methods
    private func updateUI(){
        name.text = iExpectAConnectionBack.name
        location.text = iExpectAConnectionBack.address
        let imageData = iExpectAConnectionBack.connectionPicture
        DispatchQueue.global().async {
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.connectionImage.image = image
            }
        }
  
    }

}
/*
 func addGradient(){
 var gradient: CAGradientLayer!
 let softCyan = UIColor.init(red: 156/255, green: 236/255, blue: 251/255, alpha: 1)
 let softBlue = UIColor.init(red: 101/255, green: 199/255, blue: 247/255, alpha: 1)
 let strongBlue = UIColor.init(red: 0/255, green: 82/255, blue: 212/255, alpha: 1)
 gradient = CAGradientLayer()
 gradient.frame = self.bounds
 gradient.colors = [softCyan.cgColor, softBlue.cgColor, strongBlue.cgColor]
 self.layer.addSublayer(gradient)
 }
 */
