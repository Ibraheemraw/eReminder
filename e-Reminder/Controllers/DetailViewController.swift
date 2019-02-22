//
//  DetailViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/10/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    //Outlets
    @IBOutlet weak var contenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIColor( red: 255.0, green: 255.0, blue:255.0, alpha: 0 )
        let myColor : UIColor = .white
        contenView.layer.borderColor = myColor.cgColor
        contenView.layer.borderWidth = 5
        contenView.layer.cornerRadius = 10
       // contenView.layer.borderColor
        setupNavigationBar()
    }
    
   private func setupNavigationBar(){
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "cancel", style: .plain, target: self, action: #selector(goBackToMainVC))
    
    }
    @objc func goBackToMainVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
