//
//  ViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/7/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit

class ConnectionsVC: UITableViewController {
 //Outlets
    @IBOutlet weak var tableViewObj: UITableView!
 //Private Properties
    private var dummyData: [String] = []
   private var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarView()
        searchController.delegate = self
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    private func setupNavigationBarView(){
        // Makes the navigation bar's title Larger
self.navigationController?.navigationBar.prefersLargeTitles =  true
     searchController = UISearchController.init(searchResultsController: nil) // setting it to nil becuase you don't have a search view set up
    navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // makes the search bar persistant
    }
    @IBAction func createConnectionBttn(_ sender: UIBarButtonItem) {
        let destinationVC = CreateViewController()
        self.present(destinationVC, animated: true, completion: nil)
    }
    
    
    
    
}
//extensions
extension ConnectionsVC: UISearchControllerDelegate {
    
}
