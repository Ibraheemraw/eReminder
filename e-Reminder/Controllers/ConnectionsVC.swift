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
    //MARK: - Configuration Outlets
    @IBOutlet weak var tableViewObj: UITableView!
    //MARK: - Configuration Private Properties
    private var connectionData = [Connection]()
    private var searchController: UISearchController!
    let id = "ConnectionsCell"
    private var container = AppDelegate.container // container from AppDelegate
    private var fetchResultsContoller: NSFetchedResultsController<Connection>? // fetch controller to modifgy the table view based on core data upates
    private var gradient: CAGradientLayer! // Setting up the tableview background
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarView()
        setupSearch()
        tableViewObj.delegate = self
        tableViewObj.dataSource = self
        configfetchResultsContoller()
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Configuration Actions
    @IBAction func createConnectionBttn(_ sender: UIBarButtonItem) {
        let destinationVC = CreateViewController()
        self.present(destinationVC, animated: true, completion: nil)
    }
    //MARK: - Configuration Methods
    private func setupSearch(){
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
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
            if let imageData = connection.picture as? Data {
                DispatchQueue.global().async {
                    let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.connectionImage.contentMode = .scaleAspectFill
                        cell.connectionImage?.image = image
                        
                    }
                }
            }
        }
        return cell
    }
    private func getImages(destinationViewController: DetailViewController){
        if let context = container?.viewContext{
            let request: NSFetchRequest<Connection> = Connection.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
            do {
                let connectionList = try context.fetch(request)
                destinationViewController.connectionsList = connectionList
                
                print(" there are \(destinationViewController.connectionsList.count) of connections in the connection view")
            } catch {
                print("error in gathering the images. error: \(error.localizedDescription)")
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        self.getImages(destinationViewController: viewController)
        if let connection = fetchResultsContoller?.object(at: indexPath) {
            
            viewController.connection = connection
            navigationController?.pushViewController(viewController, animated: true)
        }
        
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
//MARK: - Configuration Extensions
extension ConnectionsVC: UISearchResultsUpdating, UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let search = searchBar.text else {
            fatalError("search is nil")
        }
        if let context = container?.viewContext {
            let request: NSFetchRequest<Connection> = Connection.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
            for connection in connectionData {
                request.predicate = NSPredicate.init(format: "name = %@", connection.name ?? "name is nil")
            }
            do {
                let connections = try context.fetch(request)
                connectionData = connections
            } catch {
                print(error)
            }
            connectionData = connectionData.filter(){
                guard let name = $0.name else {
                    fatalError("name is nil")
                }
                return name.contains(search)
                
            }
        }
        tableViewObj.reloadData()
    }
    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchText = searchController.searchBar.text else {
//            fatalError("searh text is nil")
//        }
//        if searchText == ""{
//            configfetchResultsContoller()
//       } //else {
//            if let context = container?.viewContext {
//                let request: NSFetchRequest<Connection> = Connection.fetchRequest()
//                request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
//                for connection in connectionData {
//                    request.predicate = NSPredicate.init(format: "name = %@", connection.name ?? "name is nil")
//                }
//                do {
//                    let connections = try context.fetch(request)
//                    connectionData = connections
//                } catch {
//                    print(error)
//                }
//                connectionData = connectionData.filter(){
//                    guard let name = $0.name else {
//                        fatalError("name is nil")
//                    }
//                   return name.contains(searchText)
//                }
//            }
//        }
//        tableViewObj.reloadData()
    }
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
