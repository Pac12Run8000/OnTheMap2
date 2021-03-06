//
//  LocationDetailViewController.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/10/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit
import MapKit

class LocationDetailViewController: UIViewController, MKMapViewDelegate {
    
    var activityIndicator = UIActivityIndicatorView()
   
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    
    var geocoder = CLGeocoder()
    var coordinate:CLLocationCoordinate2D!
    var mapString:String!
    var mediaUrl:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        finishButton.layer.cornerRadius = 6
        finishButton.layer.masksToBounds = true
        
        navigationController?.title = "Add Location"
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpViewsForActivityIndicator()
        activityIndicator.startAnimating()
        geocoder.geocodeAddressString(mapString) { (placemarks, error) in
            
            if ((error) != nil) {
                self.showAlert(messageText: "Location cannot be found.")
                self.activityIndicator.stopAnimating()
            }
            
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                
                self.coordinate = location.coordinate
                let annotation = MKPointAnnotation()
                annotation.coordinate = self.coordinate
                
                self.mapView.addAnnotation(annotation)
                
                let viewRegion = MKCoordinateRegionMakeWithDistance(self.coordinate, 600, 600)
                self.mapView.setRegion(viewRegion, animated: true)
                performUIUpdatesOnMain {
                    self.activityIndicator.stopAnimating()
                    for subview in self.view.subviews{
                        if subview.tag == 431431 {
                            subview.removeFromSuperview()
                        }
                    }
                }
            } else {
                print("Unable to find location")
                self.activityIndicator.stopAnimating()
            }
            
            
        }
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
    
    func showAlert(messageText:String) {
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true , completion: nil)
    }
    
    func setUIEnabled(_ enabled:Bool) {
        self.finishButton.isEnabled = enabled
        if (enabled) {
            finishButton.alpha = 1.0
        } else {
            finishButton.alpha = 0.5
        }
    }
   
    @IBAction func finishButtonPressed(_ sender: Any) {
        setUpViewsForActivityIndicator()
        guard let uniqueKey = UdacityAPIClient.sharedInstance().accountID else {
            print("There is a problem with the unique key.")
            return
        }
        
        guard let firstname = UdacityAPIClient.sharedInstance().firstName else {
            print("There is a problem with the firstname.")
            return
        }
        
        guard let lastname = UdacityAPIClient.sharedInstance().lastName else {
            print("There is a problem with the lastname.")
            return
        }
        
        guard let mapstring = mapString  else {
            print("There is a problem with the mapString value.")
            return
        }
        
        guard let mediaurl = mediaUrl else {
            print("There is a problem with the mediaurl value.")
            return
        }
        
         let parameters = ["uniquekey": uniqueKey, "firstname": firstname, "lastname": lastname, "mapstring": mapstring, "mediaUrl": mediaurl, "latitude": coordinate.latitude, "longitude": coordinate.longitude] as? [String:AnyObject]
        
        self.activityIndicator.startAnimating()
        self.setUIEnabled(false)
        if (currentUserLocation != nil) {
            
            ParseAPIClient.sharedInstance().updateStudentLocation(parameters!) { (success, errMg) in
            
                performUIUpdatesOnMain {
                
                    if (success)! {
                        self.activityIndicator.stopAnimating()
                        self.setUIEnabled(true)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.showAlert(messageText: errMg!)
                    }
                }
            
            }
        } else {
            ParseAPIClient.sharedInstance().addStudentLocation(parameters!, completionForAdd: { (success, errMsg) in
                
                performUIUpdatesOnMain {
                    if (success)! {
                        self.activityIndicator.stopAnimating()
                        self.setUIEnabled(true)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.showAlert(messageText: errMsg!)
                    }
                }
            
            })
        
        }
        
    }
    

}
