//
//  MapViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/11/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
   mapView.layer.cornerRadius = 10
    }
    
}
