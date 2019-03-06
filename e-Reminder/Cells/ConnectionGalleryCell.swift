//
//  ConnectionGalleryCell.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 3/5/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class ConnectionGalleryCell: UICollectionViewCell {
    //outlets
    @IBOutlet weak var profileImage: CircularImageView!
    //
    public var connection: Connection!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
