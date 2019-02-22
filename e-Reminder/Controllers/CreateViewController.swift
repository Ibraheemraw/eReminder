//
//  CreateViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/10/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import MapKit

class CreateViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var meetupMapView: MKMapView! // the map view where the user met the person they are adding 
    
   
    @IBOutlet weak var locationBttn: UIButton!
    var tbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    @IBAction func dismissBttn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createConnection(_ sender: UIBarButtonItem) {
    }
    
    
}
