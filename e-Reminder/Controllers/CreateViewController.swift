//
//  CreateViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/10/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation
class CreateViewController: UIViewController {
    //Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var connectionBttn: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var decriptionTxtField: UITextField!
    @IBOutlet weak var meetupMapView: MKMapView! // the map view where the user met the person they are adding 
    // Private Properties
    private var longPress: UILongPressGestureRecognizer! // for long press action on the map
    var tbv: UITableView!
    private var container = AppDelegate.container
    private var imagePickerViewController: UIImagePickerController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContentViewDesign()
        configureLongPress()
    }
    //Methods
    public func showImagePicker(){
        present(imagePickerViewController, animated: true, completion: nil)
    }
    private func setupImagePicker(){
        imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self // make sure you have UIImagePickerControllerDelegate, UINavigationControllerDelegate
        addImageAlert(imagePickerViewController)
        
    }
    private func configureLongPress(){
        //create an instance of LongPressGestureRecognizer
        longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(mapLongPressAction(gestureRecognizer:)))
        //setup the longPress duration for how long the user has to press inoder for the action to kick off
        longPress.minimumPressDuration = 0.5 // defualt is 0.5
        //add the getsure to the mapview
        meetupMapView.addGestureRecognizer(longPress)
    }
   @objc private func mapLongPressAction(gestureRecognizer: UILongPressGestureRecognizer){
    //print("Long Press Action Test!")
    showAddLocationAlert(title: "Add a location", message: "Here is where you add the location of where you met the person", style: .alert) { (action) in
        
    }
    }
    private func setupContentViewDesign(){
        let myColor : UIColor = .white
        contentView.layer.borderColor = myColor.cgColor
        contentView.layer.borderWidth = 5
        contentView.layer.cornerRadius = 20
        meetupMapView.layer.cornerRadius = 15
        backgroundImageView.layer.cornerRadius = 20
    }
    
    // Actions
    @IBAction func dismissBttn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createConnection(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func setImage(_ sender: UIButton){
        setupImagePicker()
        showImagePicker()
        print("connection image has been tapped") // testing purposes
    }
}
extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //functions you'll need for the delegate //didSelect 'didFinishPickingMediaWithInfo' and didCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil) // you want to dismiss the view
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //orignal image key
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            connectionBttn.setImage(image, for: .normal)
        } else {
            print("orignal image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
