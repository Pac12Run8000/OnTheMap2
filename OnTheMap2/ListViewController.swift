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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
    

}
