//
//  FavoritesViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/10/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import CoreData
class FavoritesViewController: UIViewController {
    //Outlets
    @IBOutlet weak var collectionViewObj: UICollectionView!
    //Private properties
    private var hiddenCells: [FavoriteCell] = []
    private var searchController: UISearchController!
    private var expandedCell: FavoriteCell?
    private var isStatusBarHidden = false
    private var favoriteConnections = [Connection]()
    private var container = AppDelegate.container // container from AppDelegate
    private var fetchResultsContoller: NSFetchedResultsController<Connection>? // fetch controller to modifgy the table view based on core data upates
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    fileprivate func fetchData() {
        let request: NSFetchRequest<Connection> = Connection.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        // predicate as needed
        if let context = container?.viewContext {
            do {
                let connections = try context.fetch(request)
                favoriteConnections = connections
                
                print("found \(connections.count) connections")
            } catch {
                print("fetching connections error: \(error.localizedDescription)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewObj.delegate = self
        collectionViewObj.dataSource = self
        setupNavigationBarView()
        fetchData()
       collectionViewObj.reloadData()
    }

    private func setupNavigationBarView(){
        // Makes the navigation bar's title Larger
        self.navigationController?.navigationBar.prefersLargeTitles =  true
        searchController = UISearchController.init(searchResultsController: nil) // setting it to nil becuase you don't have a search view set up
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // makes the search bar persistant
    }
    //Actions
    @IBAction func followUpPressed(_ sender: Any) {
        
        let string = "Hello, world!"
        let url = URL(string: "https://www.youtube.com/")!

        let activityViewController =
            UIActivityViewController.init(activityItems: [string, url], applicationActivities: nil)
        
        present(activityViewController, animated: true) {
          
        }
    }
    
}
extension FavoritesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteConnections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell else {
            fatalError("Collection View Cell is nil")
        }
        let settingCells = favoriteConnections[indexPath.row]
        cell.nameObj.text = settingCells.name
        cell.emailObj.text = settingCells.email
        cell.textView?.text = settingCells.detailDescription
        if let imageData = settingCells.picture as? Data {
            DispatchQueue.global().async {
               let image = UIImage.init(data: imageData)
                DispatchQueue.main.async {
                   cell.profileImage.image = image
                }
            }
        }
        
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.contentOffset.y < 0 ||
            collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
            return
        }
    
        let dampingRatio: CGFloat = 0.8
        let initialVelocity = CGVector.zero
        let springParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
        
        
        self.view.isUserInteractionEnabled = false
        
        if let selectedCell = expandedCell {
            isStatusBarHidden = false
            
            animator.addAnimations {
                selectedCell.collapse()
                for cell in self.hiddenCells {
                    cell.show()
                }
            }
            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true
                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            isStatusBarHidden = true
            
            collectionView.isScrollEnabled = false
            
            let selectedCell = collectionView.cellForItem(at: indexPath)! as! FavoriteCell
            let frameOfSelectedCell = selectedCell.frame
            expandedCell = selectedCell
            
            hiddenCells = collectionView.visibleCells.map { $0 as! FavoriteCell }.filter { $0 != selectedCell }
            animator.addAnimations {
                selectedCell.expand(in: collectionView)
                for cell in self.hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
        }
        animator.addAnimations {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        animator.addCompletion { _ in
            self.view.isUserInteractionEnabled = true
        }
        
        animator.startAnimation()
}
}
