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
import MessageUI
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
    @IBOutlet weak var collectionViewContentView: UIView!
    @IBOutlet weak var connectionList: UICollectionView!
    @IBOutlet weak var favoriteBttn: FaveButton!
    @IBOutlet weak var emailButton: FaveButton!
    @IBOutlet weak var eventBttn: FaveButton!
    @IBOutlet weak var profileImage: CircularImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailEmailLabel: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    //Properties
    private var container = AppDelegate.container // is the database that holds our model
    public var connection: Connection!
    public var myConnection: MyConnection!
    public var myFavoriteConnection: MyConnection!
    public var connectionsList = [Connection]()
    private var fetchResultsContoller: NSFetchedResultsController<Connection>!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentViewDesign()
        setupFavButton()
        setupNavigationBar()
        fetchData()
        connectionList.dataSource = self
        connectionList.delegate = self
        connectionList.reloadData()
        
    }
    private func setupContentViewDesign(){
        let myColor : UIColor = .white
       
       collectionViewContentView.layer.borderColor = myColor.cgColor
        contentView.layer.borderColor = myColor.cgColor
        
       collectionViewContentView.layer.borderWidth = 5
        contentView.layer.borderWidth = 5
       collectionViewContentView.layer.cornerRadius = 10
        contentView.layer.cornerRadius = 10
    }
   private func setupNavigationBar(){
    navigationItem.largeTitleDisplayMode = .never
    
    }
    private func fetchData() {
       detailNameLabel.text = connection.name
        detailEmailLabel.text = connection.email
        detailDescription.text = connection.detailDescription
        if let imageData = connection.picture as? Data {
            DispatchQueue.global().async {
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.profileImage.contentMode = .scaleAspectFill
                    self.profileImage.image = image
                }
            }
        }
    }
    private func saveToFavorites(){
        if let imageData = profileImage.image?.jpegData(compressionQuality: 0.5){
            let textExmaple = "hello"
            detailDescription.text = textExmaple
            let myFavoriteConnection = MyConnection.init(user: nil, name: detailNameLabel.text  ?? "name is nil", email: detailEmailLabel.text ?? "email is nil", address: connection.address ?? "address is nil", latitude: connection.lat, isFavorite: true, longitude: connection.lng, createdDate: nil, lastMeetupDate: nil, description: textExmaple , connectionPicture: imageData)
            self.myFavoriteConnection = myFavoriteConnection
        }
    }
    @objc func goBackToMainVC(){
        self.dismiss(animated: true, completion: nil)
    }
    private func setupFavButton() {
      self.emailButton?.setSelected(selected: false, animated: false)
       self.favoriteBttn?.setSelected(selected: false, animated: false)
        emailButton.selectedColor = .yellow
        eventBttn.selectedColor = .orange
        
        eventBttn.delegate = self
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
        guard let name = detailNameLabel.text else {
            print("name is nil")
            return
        }
        
        if let context = container?.viewContext {
            do {

                
                let request: NSFetchRequest<Connection> = Connection.fetchRequest()
                request.predicate = NSPredicate(format: "name = %@", name)
                //do {
                let results = try context.fetch(request)
                
                guard let connectionToUpdate = results.first else {
                    print("no connection")
                    return
                }
                connectionToUpdate.isFavorite = true
                try? context.save()
                
                showAlert(title: "Added ❤️", message: "\(name) has been added to your Favorites", style: .alert)
            } catch {
                showAlert(title: "⚠️Error Saving This Connection⚠️", message: (error as! AppError).errorMessage(), style: .alert)
            }
        }
        
    }
    @IBAction func sendMessage(_ sender: FaveButton){
        guard let bodyText = detailNameLabel.text else {
            print("name is nil")
            return
        }
        // step 3 create a condition where if you can send mail
        if MFMailComposeViewController.canSendMail(){
            // step 4 create a mailComposeViewController instance
            let mailComposeViewController = MFMailComposeViewController()
            // step 5 create the recipients
            mailComposeViewController.setToRecipients(["\(String(describing: detailEmailLabel.text))"])
            // step 6 set the subject
            mailComposeViewController.setSubject("Follow Up !")
            // step 7 set the message body
            mailComposeViewController.setMessageBody("Hey, \(bodyText) I am writing to you becuase....", isHTML: false)
            // step 8 set the delegate
            mailComposeViewController.mailComposeDelegate = self
            // step 9 present the contoller
            present(mailComposeViewController, animated: true, completion: nil)
        } else {
            print("issue with create a email message")
        }
    }
    @IBAction func createEvent(_ sender: FaveButton){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let createAndAddEventViewController = storyBoard.instantiateViewController(withIdentifier: "CreateAndAddEventController") as! CreateAndAddEventController
        createAndAddEventViewController.modalPresentationStyle = .overCurrentContext
        present(createAndAddEventViewController, animated: true, completion: nil)
    }
}
extension DetailViewController: FaveButtonDelegate{
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {

    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(" there are \(connectionsList.count) of connections in the detail view")
        return connectionsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ConnectionGalleryCell", for: indexPath) as? ConnectionGalleryCell else {
            print("collection view cell is nil")
            return UICollectionViewCell()
        }
        let settingCells = connectionsList[indexPath.row]
        if let imageData = settingCells.picture as? Data {
            DispatchQueue.global().async {
                let image = UIImage.init(data: imageData)
                DispatchQueue.main.async {
                    cell.profileImage.contentMode = .scaleAspectFill
                    cell.profileImage.image = image
                }
            }
        }
        cell.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you can press")
        favoriteBttn.setSelected(selected: false, animated: false)
        eventBttn.setSelected(selected: false, animated: false)
        emailButton.setSelected(selected: false, animated: false)
        let connection = connectionsList[indexPath.row]
        detailNameLabel.text = connection.name
        detailEmailLabel.text = connection.email
        detailDescription.text = connection.detailDescription
        if let imageData = connection.picture as? Data {
            DispatchQueue.global().async {
                let image = UIImage.init(data: imageData)
                DispatchQueue.main.async {
                    self.profileImage.image = image
                }
                
            }
        }
        
    }
    
}
extension DetailViewController: MFMailComposeViewControllerDelegate {
    // 10 setup the didFinishWith result function to dismiss the email
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
