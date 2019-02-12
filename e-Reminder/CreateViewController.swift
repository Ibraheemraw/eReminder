//
//  CreateViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/10/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController {
    
    @IBOutlet weak var locationBttn: UIButton!
    var tbv: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func dismissBttn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveLocation(_ sender: Any) {
        print("Location is saved")
    }
    
}
