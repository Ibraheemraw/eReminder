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
//        configCell()
    }
//    private func configCell(){
//        if let imageData = connection.picture as? Data {
//            DispatchQueue.global().async {
//                let image = UIImage.init(data: imageData)
//                DispatchQueue.main.async {
//                    self.profileImage.image = image
//                }
//            }
//        }
//    }
    
}
