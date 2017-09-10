//
//  ListViewController.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/9/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let logoutButton = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutButtonPress))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [addButton, refreshButton]
        navigationItem.leftBarButtonItems = [logoutButton]
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        upDateLocationsForTableView()
        
    }
    
    func upDateLocationsForTableView() {
        setUpViewsForActivityIndicator()
        activityIndicator.startAnimating()
        ParseAPIClient.sharedInstance().getStudentLocation { (success, errMsg) in
            
            ParseAPIClient.sharedInstance().getStudentLocations { (success, errMsg) in
                
                DispatchQueue.global(qos: .userInitiated).async { () -> Void in
                    
                    performUIUpdatesOnMain {
                        self.activityIndicator.stopAnimating()
                        
//                        print("locations:\(String(describing: ParseAPIClient.sharedInstance().allLocations))")
                        
//                        self.pinLocationsOnMapView(locations: ParseAPIClient.sharedInstance().allLocations)
                        
                        for subview in self.view.subviews{
                            if subview.tag == 431431 {
                                subview.removeFromSuperview()
                            }
                        }
                    }
                }
            }
        }
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
    
    func addTapped() {
    
    }
    
    func refreshTapped() {
        upDateLocationsForTableView()
    }
    
    func showAlert(messageText:String) {
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true , completion: nil)
    }
    

}

extension ListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ParseAPIClient.sharedInstance().allLocations?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let allLocations = ParseAPIClient.sharedInstance().allLocations
        
        let cellReuseIdentifier = "cell"
        
        let location = allLocations?[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        let firstname = location?.firstName ?? "[No first name]"
        let lastname = location?.lastName ?? "[No last name]"
        
        cell?.textLabel?.text = firstname + " " + lastname
        
        
        cell?.detailTextLabel?.text = location?.mediaURL ?? "[No Media Url]"
        
        
        return cell!
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let allLocations = ParseAPIClient.sharedInstance().allLocations
        
        let location = allLocations?[(indexPath as NSIndexPath).row]
        if (location?.mediaURL == nil) {
            self.showAlert(messageText: "There url value is nil.")
        } else {
            let urlString = location?.mediaURL
            if let url = URL(string: urlString!) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

}
