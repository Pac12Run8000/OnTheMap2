//
//  MapViewController.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/9/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoutButton = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutButtonPress))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
        navigationItem.leftBarButtonItems = [logoutButton]
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upDateLocationsForMap()
    }
    
    func logoutButtonPress() {

        UdacityAPIClient.sharedInstance().logOutUdacityUser { (success, errMsg) in
            
            performUIUpdatesOnMain {
                if (success!) {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showAlert(messageText: "An error occurred during logout.")
                }
            }
            
        }
        
    }
    
    func addTapped() {
    
    }
    
    func refreshTapped() {
    
    }
    
    func showAlert(messageText:String) {
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true , completion: nil)
    }
    
    func upDateLocationsForMap() {
        setUpViewsForActivityIndicator()
        activityIndicator.startAnimating()

        ParseAPIClient.sharedInstance().getStudentLocations { (success, errMsg) in
            
                DispatchQueue.global(qos: .userInitiated).async { () -> Void in
                
                performUIUpdatesOnMain {
                    self.activityIndicator.stopAnimating()

                    self.pinLocationsOnMapView(locations: ParseAPIClient.sharedInstance().allLocations)

                    
                    for subview in self.view.subviews{
                        if subview.tag == 431431 {
                            subview.removeFromSuperview()
                        }
                    }
                }
            }
        }
    }
    
    func pinLocationsOnMapView(locations:[Location]?) {
        
        var annotations = [MKPointAnnotation]()
        if let myLocations = locations {
            for location in myLocations {
                
                let lat = CLLocationDegrees((location.latitude ?? 0.00 ))
                
                let long = CLLocationDegrees((location.longitude ?? 0.00 ))
                
                
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                
                let annotation = MKPointAnnotation()
                
                
                if let last = location.lastName, let first = location.firstName {
                    annotation.title = "\(first) \(last)"
                }
                
                
                if let mediaURL = location.mediaURL {
                    annotation.subtitle = mediaURL
                }
                
                annotation.coordinate = coordinate
                annotations.append(annotation)
            }
        }
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotations(annotations)
    }
    
    func setUpViewsForActivityIndicator() {
        let mainContainer: UIView = UIView(frame: self.view.frame)
        mainContainer.center = self.view.center
        mainContainer.backgroundColor = UIColor.gray
        mainContainer.alpha = 0.5
        mainContainer.tag = 431431
        mainContainer.isUserInteractionEnabled = false
        
        let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 80,height: 80))
        viewBackgroundLoading.center = self.view.center
        viewBackgroundLoading.backgroundColor = UIColor.purple
        viewBackgroundLoading.alpha = 0.5
        viewBackgroundLoading.clipsToBounds = true
        viewBackgroundLoading.layer.cornerRadius = 15
        
        viewBackgroundLoading.addSubview(activityIndicator)
        mainContainer.addSubview(viewBackgroundLoading)
        
        self.view.addSubview(mainContainer)
        self.view.addSubview(self.activityIndicator)
        
    }

    
    

    

}
