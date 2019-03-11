//
//  MapViewController.swift
//  e-Reminder
//
//  Created by Ibraheem rawlinson on 2/11/19.
//  Copyright © 2019 Ibraheem rawlinson. All rights reserved.
//

import UIKit
import MapKit
import CoreData
import Toucan
class MapViewController: UIViewController {
    //Outlets
    @IBOutlet weak var mapView: MKMapView!
    private var connectionLocations = [Connection]() {
        didSet{
            mapView.reloadInputViews()
        }
    } // Holds an array of connection location the user made
    private var container = AppDelegate.container // container from AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapViewUI()
        setupAnnotations()
    }
    private func setupMapViewUI(){
        mapView.layer.cornerRadius = 10
        mapView.delegate = self
        fetchData()
    }
    private func fetchData(){
        let request: NSFetchRequest<Connection> = Connection.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor.init(key: "name", ascending: true)]
        if let context = container?.viewContext {
            do {
                let locations = try context.fetch(request)
                connectionLocations = locations
                print("found \(locations.count) locations")
            } catch {
                print("error in fetching locations Data \(error.localizedDescription)")
            }
        }
    }
    private func setupAnnotations(){
        for location in connectionLocations {
            // set up the region - how close should
            let regionRadius: CLLocationDistance = 7900000
            // get the coordinates
            let coordinate = CLLocationCoordinate2D.init(latitude: location.lat, longitude: location.lng)
            //set the coordinate region
            let coordinateRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            //Create an instance of an Annotation
            let annotation = MKPointAnnotation()
            
            //Giving the annotation a coordinate
            annotation.coordinate = coordinate
            annotation.title = location.name
            annotation.subtitle = location.address
            mapView.setRegion(coordinateRegion, animated: true)
            mapView.addAnnotation(annotation)
        }
    }
}
extension MapViewController: MKMapViewDelegate{
    //view for Annotion
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "maker"
        guard annotation is MKPointAnnotation else {
            print("annotation is nil")
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
//            for picture in connectionLocations {
//
//                if let imageData = picture.picture as? Data {
//                    let image = UIImage.init(data: imageData)
//                    DispatchQueue.global().async {
//                        let resizedImage = Toucan.init(image: image!).resize(CGSize.init(width: 100, height: 100))
//                        annotationView?.image = resizedImage.image
//
//                    }
//                }
//            }
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
