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
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentViewDesign()
       // contenView.layer.borderColor
        setupNavigationBar()
    }
    private func setupContentViewDesign(){
        let myColor : UIColor = .white
        contentView.layer.borderColor = myColor.cgColor
        contentView.layer.borderWidth = 5
        contentView.layer.cornerRadius = 10
    }
   private func setupNavigationBar(){
    navigationItem.largeTitleDisplayMode = .never
    navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "cancel", style: .plain, target: self, action: #selector(goBackToMainVC))
    
    }
    @objc func goBackToMainVC(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
