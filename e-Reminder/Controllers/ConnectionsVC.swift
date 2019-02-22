//
//  ViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/7/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
struct cellData {
    var opened = Bool()
    var title = String()
    var sectionData = [String]()
    
}

class ConnectionsVC: UITableViewController {
 //Outlets
    @IBOutlet weak var tableViewObj: UITableView!
 //Private Properties
    private var tableViewData = [cellData]()
   private var searchController: UISearchController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarView()
        searchController.delegate = self
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        tableViewData = [cellData.init(opened: false, title: "First Connection", sectionData: ["Name", "Email", "Description of the person", "Location where they met"]), cellData.init(opened: false, title: "Second Connection", sectionData: ["Name", "Email", "Description of the person", "Location where they met"]), cellData.init(opened: false, title: "Third Connection", sectionData: ["Name", "Email", "Description of the person", "Location where they met"])]
     
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true {
            //testing to see if in this section is this expaned or opened
            return tableViewData[section].sectionData.count + 1
        } else {
            //if not return a certain value
            return 1 // we only want one header to return if it isnot expanded or open
        }
    }
    //"ConnectionsCell"
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataIndex = indexPath.row - 1
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionsCell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].title
            return cell
        } else {
            // user different cell ID if needed
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionsCell") else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if tableViewData[indexPath.section].opened == true {
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section) // becuase we want an array of sections
                tableView.reloadSections(sections, with: .none) // play around with this!!!!
            } else {
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section) // becuase we want an array of sections
                tableView.reloadSections(sections, with: .none) // play around with this!!!!
            }
        } else {
            let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail")
            
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.modalTransitionStyle = .coverVertical
            self.present(viewController, animated: true, completion: nil)
        }
        
    }
}
//extensions
extension ConnectionsVC: UISearchControllerDelegate {
    
}
