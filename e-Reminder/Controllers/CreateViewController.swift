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
    @IBOutlet weak var contentView: UIView!//the child view containing all of the objects (labels, textfields, mapview and button)
    @IBOutlet weak var backgroundImageView: UIImageView!//setting the gradient background
    @IBOutlet weak var connectionBttn: UIButton!//for changing the image of the connection you made
    @IBOutlet weak var profileImage: CircularImageView!
    @IBOutlet weak var name: UILabel! // name of the person you have connected with
    @IBOutlet weak var nameTextField: UITextField! // user enters the persons name
    @IBOutlet weak var email: UILabel! // email of person you have connected with
    @IBOutlet weak var emailTextField: UITextField!// user enters the persons email
    @IBOutlet weak var descriptionLabel: UILabel! // Description label title
    @IBOutlet weak var decriptionTxtField: UITextField! //user adds a small description about the person
    @IBOutlet weak var meetupMapView: MKMapView! // the map view where the user met the person they are adding 
    // Private Properties
    private var longPress: UILongPressGestureRecognizer!//for long press action on the map
    private var container = AppDelegate.container // Holds our coreData Database
    private var imagePickerViewController: UIImagePickerController! //Being able to set up the picture using the photogallery or camera
    private var locationInput: String? //for the alertController textfield
    private var connectionName: String?
    private var connectionEmail: String?
    private var connectionDescription: String?
    private let identifier = "marker" // for the mapView
    var lat: Double?
    var long: Double?
    private var image: UIImage?
    private var myConnection: MyConnection!
    private var googleAddressReults = [Results](){
        didSet{
            DispatchQueue.main.async {
                self.meetupMapView.reloadInputViews()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContentViewDesign()
        configureLongPress()
        setupDelegates()
        nameTextField.placeholder = "Ex: Ibraheem..."
        emailTextField.placeholder = "Ex: Ibraheem@me.com..."
        decriptionTxtField.placeholder = "Something about the person..."
        self.image = profileImage.image
        
    }
    
    //Methods
    private func createConnection(){
        if let imageData = image?.jpegData(compressionQuality: 0.5){
            let newConnection = MyConnection.init(user: nil, name: connectionName ?? "name is nil", email: connectionEmail ?? "email is nil", address: locationInput ?? "address is nil", latitude: lat ?? 0.0, longitude: long ?? 0.0, createdDate: nil, lastMeetupDate: nil, description: connectionDescription ??  "description is nil", connectionPicture: imageData)
            self.myConnection = newConnection
        }
    }
    public func showImagePicker(){ // Presents photogallery or camera
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
        meetupMapView.addGestureRecognizer(longPress) // when the user holds on to the map it will take them 1/2 sec for them to see the alert controller
    }
    private func setupDelegates(){ // for listening in for when the user selects the textfields, and Mapview. Also when they click the return button
        nameTextField.delegate = self
        emailTextField.delegate = self
        decriptionTxtField.delegate = self
        meetupMapView.delegate = self
    }
    private func getLocationInfo(input: String){ // getting the address from the endpoint (formatted adress, lat and lng)
        GeocodingApiClient.createLocations(userInput: input) { [weak self](googleAddressReults, appError) in
            if let appError = appError {
                print(appError.localizedDescription)
            }
            if let googleAddressReults = googleAddressReults {
                self?.googleAddressReults = googleAddressReults
                print("\(input)")
                DispatchQueue.main.async {
                    self?.setupAnnotation()
                    self?.meetupMapView.reloadInputViews()
                }
            }
        }
    }
   @objc private func mapLongPressAction(gestureRecognizer: UILongPressGestureRecognizer){
    let alertController = UIAlertController.init(title: "Add a location", message: "Here is where you add the location of where you met the person", preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    let customAction = UIAlertAction(title: "Create", style: .default){(success) in
        guard let userInput = alertController.textFields?.first?.text else {
            print("alertController textField is nil")
            return
        }
        self.locationInput = userInput
        self.getLocationInfo(input: userInput)
    }
    alertController.addTextField { (text) in
        text.placeholder = "Search for a place or a address"
        text.textAlignment = .center
    }
    alertController.addAction(cancelAction)
    alertController.addAction(customAction)
    present(alertController, animated: true)
    }
    private func setupContentViewDesign(){
        let myColor : UIColor = .white
        contentView.layer.borderColor = myColor.cgColor
        contentView.layer.borderWidth = 5
        contentView.layer.cornerRadius = 20
        meetupMapView.layer.cornerRadius = 15
        backgroundImageView.layer.cornerRadius = 20
    }
    private func setupAnnotation(){
        //looping through the the array of resutls to setup the annotation
        for result in googleAddressReults {
            // set up the region - how close should
            let regionRadius: CLLocationDistance = 8000
            //get the coordinates
            let coordinate = CLLocationCoordinate2D.init(latitude: result.geometry.location.lat, longitude: result.geometry.location.lng)
            //set the coordinate region
            let coordinateRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            //Create an instance of an Annotation
            let annotation = MKPointAnnotation()
            //Giving the annotation a coordinate
            annotation.coordinate = coordinate
            // giving the annotation a title from the GoogleGeocoding Model
             self.lat = annotation.coordinate.latitude as! Double
             self.long = annotation.coordinate.longitude as! Double
            annotation.title = locationInput! // assigning what the user types in to the title of the annotation
            // set the mapview to the coordinate region
            meetupMapView.setRegion(coordinateRegion, animated: true)
            // setting the annotation on the mapview
            meetupMapView.addAnnotation(annotation)
        }
    }
    // Actions
    @IBAction func dismissBttn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createConnection(_ sender: UIBarButtonItem) {
        //create a connection
        if let context = container?.viewContext { // context is the container of the app delegate
            createConnection()
            do {
                let _ = try Connection.createConnections(connectionInfo: myConnection, context: context)
                //======================================
                // PLEASE REMEMEBER TO SAVE THE CONTEXT
                //======================================
                try? context.save()
                navigationItem.rightBarButtonItem?.isEnabled = false
                showAlert(title: "Saved 🤗", message: "You created a new connection for \(myConnection.name)", style: .alert)
            } catch {
                showAlert(title: "⚠️Error Saving This Connection⚠️", message: (error as! AppError).errorMessage(), style: .alert)
            }
        }
    }
    @IBAction func setImage(_ sender: UIButton){
        setupImagePicker()
        showImagePicker()
        print("connection image has been tapped") // testing purposes
    }
}
//Extension
extension CreateViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //functions you'll need for the delegate //didSelect 'didFinishPickingMediaWithInfo' and didCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil) // you want to dismiss the view
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //orignal image key
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.contentMode = .scaleAspectFit
            profileImage.image = image
            self.image = image
        } else {
            print("orignal image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
extension CreateViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nameInput = nameTextField.text, let emailInput = emailTextField.text, let descriptionInput = decriptionTxtField.text else {
            fatalError("nameInput, emailInput, and descriptionInput is empty")
        }
        if nameInput.isEmpty || emailInput.isEmpty || descriptionInput.isEmpty  {
            showAlert(title: "Remeber", message: "Don't Forget to press return", style: .alert)
        }
        if !nameInput.isEmpty && !emailInput.isEmpty && !descriptionInput.isEmpty {
            showAlert(title: "Add a loaction", message: "Now that you have filled all of the requirements. long press on the map and enter in your location", style: .alert)
        }
        self.connectionName = nameInput
        self.connectionEmail = emailInput
        self.connectionDescription = descriptionInput
        print("name: \(nameInput) ,email: \(emailInput),description: \(descriptionInput)")
        return textField.resignFirstResponder()
    }
        
}
extension CreateViewController: MKMapViewDelegate{
    //view for Annotion
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            print("annotation is nil")
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
           annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
