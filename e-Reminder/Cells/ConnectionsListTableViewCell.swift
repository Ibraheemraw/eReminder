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
