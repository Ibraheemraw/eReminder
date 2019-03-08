//
//  DraftsViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/10/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class MessagingViewController: UIViewController {
    private var searchController: UISearchController!
    @IBOutlet weak var subscribe: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarView()
        let myColor : UIColor = .white
        subscribe.layer.borderColor = myColor.cgColor
        subscribe.layer.borderWidth = 3
        subscribe.layer.cornerRadius = 10
    }
    
    private func setupNavigationBarView(){
        // Makes the navigation bar's title Larger
self.navigationController?.navigationBar.prefersLargeTitles =  true
        searchController = UISearchController.init(searchResultsController: nil) // setting it to nil becuase you don't have a search view set up
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // makes the search bar persistant
    }
}
