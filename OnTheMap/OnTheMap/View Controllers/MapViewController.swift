//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Tristan Pudell-Spatscheck on 5/2/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import Foundation
import UIKit
import MapKit

/**
 * This view controller demonstrates the objects involved in displaying pins on a map.
 *
 * The map is a MKMapView.
 * The pins are represented by MKPointAnnotation instances.
 *
 * The view controller conforms to the MKMapViewDelegate so that it can receive a method
 * invocation when a pin annotation is tapped. It accomplishes this using two delegate
 * methods: one to put a small "info" button on the right side of each pin, and one to
 * respond when the "info" button is tapped.
 */

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // The map. See the setup in the Storyboard file. Note particularly that the view controller
    // is set up as the map view's delegate.
    @IBOutlet weak var mapView: MKMapView!
    let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
    
    
    func loadingIsDone() {
        let locations = studentLoc.getStudentResp()?.results
        
        
        
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        var annotations = [MKPointAnnotation]()
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        
        for dictionary in locations! {
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
            if (dictionary.latitude != nil && dictionary.longitude != nil) {
                let lat = CLLocationDegrees(dictionary.latitude as! Float)
                let long = CLLocationDegrees(dictionary.longitude as! Float)
                
                // The lat and long are used to create a CLLocationCoordinates2D instance.
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let fullName = dictionary.fullName
                let mediaURL = dictionary.realURL
                
                // Here we create the annotation and set its coordiate, title, and subtitle properties
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = fullName
                annotation.subtitle = mediaURL
                
                // Finally we place the annotation in an array of annotations.
                annotations.append(annotation)
            }
            self.myActivityIndicator.stopAnimating()
        }
        
        // When the array is complete, we add the annotations to the map after removing the current values
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
    }
    
    override func viewDidLoad() {
        refreshData.DataDone=self.loadingIsDone
        refreshData.ActivityIndicator=myActivityIndicator
        super.viewDidLoad()
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = self.view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        
        self.view.addSubview(myActivityIndicator)
        if(studentLoc.posting) {
            // If posting is true we already loaded a single student in the data structure so just call loading is done to put it on the map.
            loadingIsDone()
        } else {
            studentLoc.getStudentLocation(loadingIsDone: self.loadingIsDone)
        }
    }
    
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(animated)
        refreshData.DataDone=self.loadingIsDone
        refreshData.ActivityIndicator=myActivityIndicator
    }
    
    
    // MARK: - MKMapViewDelegate
    
    // Here we create a view with a "right callout accessory view". You might choose to look into other
    // decoration alternatives. Notice the similarity between this method and the cellForRowAtIndexPath
    // method in TableViewDataSource.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if(studentLoc.posting) {
            //tells user the controlls
             let alertLogin = CentralData().popupAlert(alertT: "Preview Controller", alertMsg: "Click the + button on the pin to confirm location, Press Refresh to cancel", okText: "OK")
            self.present(alertLogin, animated: true, completion: nil)
            let reuseId = "post"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.pinTintColor = .red
                pinView!.rightCalloutAccessoryView = UIButton(type: .contactAdd)
            }
            else {
                pinView!.annotation = annotation
            }
            return pinView
        } else {
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                pinView!.pinTintColor = .red
                pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
            else {
                pinView!.annotation = annotation
            }
            return pinView
        }
    }
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if(studentLoc.posting) {
            // post the current user if + on call out is pressed
            studentLoc.postFirstStudentLocation()
            // now reload regular users
            refreshData.refresh()
        } else {
            if control == view.rightCalloutAccessoryView {
                let app = UIApplication.shared
                if let toOpen = view.annotation?.subtitle! {
                    app.open(URL(string: toOpen)!)
                }
            }
        }
    }
}
