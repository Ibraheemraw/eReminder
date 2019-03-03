//
//  DetailViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/10/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import MapKit
import FaveButton
import CoreData
func color(_ rgbColor: Int) -> UIColor{
    return UIColor(
        red:   CGFloat((rgbColor & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbColor & 0x00FF00) >> 8 ) / 255.0,
        blue:  CGFloat((rgbColor & 0x0000FF) >> 0 ) / 255.0,
        alpha: CGFloat(1.0)
    )
}

class DetailViewController: UIViewController {
    //Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var favoriteBttn: FaveButton!
    @IBOutlet weak var emailButton: FaveButton!
    @IBOutlet weak var profileImage: CircularImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailEmailLabel: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    //Properties
    private var container = AppDelegate.container // is the database that holds our model
    public var connection: Connection!
    private var fetchResultsContoller: NSFetchedResultsController<Connection>!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentViewDesign()
        setupFavButton()
        setupNavigationBar()
        fetchData()
        
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
    private func fetchData() {
       detailNameLabel.text = connection.name
        detailEmailLabel.text = connection.email
        detailDescription.text = connection.description
        if let imageData = connection.picture as? Data {
            DispatchQueue.global().async {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.profileImage.image = image
                }
            }
        }
    }
    @objc func goBackToMainVC(){
        self.dismiss(animated: true, completion: nil)
    }
    private func setupFavButton() {
      self.emailButton?.setSelected(selected: false, animated: false)
       self.favoriteBttn?.setSelected(selected: false, animated: false)
        emailButton.selectedColor = .yellow
       favoriteBttn.delegate = self
        emailButton.delegate = self
    }
    let colors = [
        DotColors(first: color(0x7DC2F4), second: color(0xE2264D)),
        DotColors(first: color(0xF8CC61), second: color(0x9BDFBA)),
        DotColors(first: color(0xAF90F4), second: color(0x90D1F9)),
        DotColors(first: color(0xE9A966), second: color(0xF8C852)),
        DotColors(first: color(0xF68FA7), second: color(0xF6A2B8))
    ]
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]?{
        if faveButton == favoriteBttn || faveButton == emailButton {
            return colors
        }
        return nil
    }
    @IBAction func addToFavorties(_ sender: FaveButton){
        
    }
    @IBAction func sendMessage(_ sender: FaveButton){
        
    }
}
extension DetailViewController: FaveButtonDelegate{
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        
    }
}

extension DetailViewController: NSFetchedResultsControllerDelegate {
    
}
