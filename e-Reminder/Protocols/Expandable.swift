//
//  Expandable.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/11/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

protocol Expandable {
    func collapse()
    func expand(in collectionView: UICollectionView)
}
