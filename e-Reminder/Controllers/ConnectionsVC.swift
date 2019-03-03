//
//  ViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/7/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import CoreData
class ConnectionsVC: UITableViewController {
    //Outlets
    @IBOutlet weak var tableViewObj: UITableView!
    //Private Properties
    private var connectionData = [ConnectionInfo]()
    private var searchController: UISearchController!
    let id = "ConnectionsCell"
    private var container = AppDelegate.container // container from AppDelegate
    private var fetchResultsContoller: NSFetchedResultsController<Connection>? // fetch controller to modifgy the table view based on core data upates
    private var gradient: CAGradientLayer! // Setting up the tableview background
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarView()
        searchController.delegate = self
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        configfetchResultsContoller()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        addGradient()
    }
    
    //Actions
    @IBAction func createConnectionBttn(_ sender: UIBarButtonItem) {
        let destinationVC = CreateViewController()
        self.present(destinationVC, animated: true, completion: nil)
    }
    //Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController, let indexPath = tableViewObj.indexPathForSelectedRow else {
            fatalError("DetailViewController is nil")
        }
        let connection = fetchResultsContoller?.object(at: indexPath)
        destination.connection = connection
    }
    private func setupNavigationBarView(){
        // Makes the navigation bar's title Larger
        self.navigationController?.navigationBar.prefersLargeTitles =  true
        searchController = UISearchController.init(searchResultsController: nil) // setting it to nil becuase you don't have a search view set up
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // makes the search bar persistant
    }
    private func configfetchResultsContoller(){
        if let context = container?.viewContext{
            // create a request
            let request: NSFetchRequest<Connection> = Connection.fetchRequest()
            // Assign NSSortDescriptor
            request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
            //
            fetchResultsContoller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            // set the delegate
            fetchResultsContoller?.delegate = self
            do {
                try fetchResultsContoller?.performFetch()
            } catch {
                showAlert(title: "Error fetching data", message: "Try Again", style: .alert)
            }
            tableViewObj.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultsContoller?.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as? ConnectionsListTableViewCell else {
            print("Generic TableViewCell")
            return UITableViewCell()
        }
        if let connection = fetchResultsContoller?.object(at: indexPath){
            cell.name?.text = connection.name
            cell.location?.text = connection.address
            cell.imageView?.image = UIImage(named: "profile-placeholder")// reloaded the imageData saved to Core Data
            if let imageData = connection.picture as? Data {
                DispatchQueue.global().async {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.connectionImage?.image = image
                    }
                }
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Detail")
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .coverVertical
        self.present(viewController, animated: true, completion: nil)
    }
    // TableView Delegate
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if let connection = fetchResultsContoller?.object(at: indexPath){
            container?.viewContext.delete(connection)
            try? container?.viewContext.save()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
//extensions
extension ConnectionsVC: UISearchControllerDelegate {
    
}
extension ConnectionsVC: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewObj.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType){
        switch type {
            case .insert:
                tableViewObj.insertSections([sectionIndex], with: .fade)
            case .delete:
                tableViewObj.deleteSections([sectionIndex], with: .fade)
            default:
                break
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableViewObj.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableViewObj.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableViewObj.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableViewObj.deleteRows(at: [indexPath!], with: .fade)
            tableViewObj.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewObj.endUpdates()
    }
}
