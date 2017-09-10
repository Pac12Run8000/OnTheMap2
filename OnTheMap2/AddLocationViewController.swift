//
//  AddLocationViewController.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/9/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var findLocationButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var websiteTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Add Location"
        findLocationButton.layer.cornerRadius = 6
        findLocationButton.layer.masksToBounds = true
        
        
        let dismissButton = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(dismissButtonPressed))
        navigationItem.leftBarButtonItems = [dismissButton]
    }
    
    
    @IBAction func findLocationButtonPressed(_ sender: Any) {
        guard let location = locationTextField.text else {
            return
        }
        guard let url = websiteTextField.text else {
            return
        }
        
        if (location.isEmpty || location == "") {
            showAlert(messageText: "Please enter a location.")
        } else if (url.isEmpty || url == "") {
            showAlert(messageText: "Enter a url.")
        } else if (!validateUrl(urlString: url as NSString)) {
            showAlert(messageText: "The website url entered is not valid.")
        } else {
            let locationDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "LocationDetailViewController") as! LocationDetailViewController
            locationDetailViewController.mapString = location
            locationDetailViewController.mediaUrl = url
            
            navigationController?.pushViewController(locationDetailViewController, animated: true)
            
        }
        
    }
    
    func dismissButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    func showAlert(messageText:String) {
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true , completion: nil)
    }
    
    func validateUrl (urlString: NSString) -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: urlString)
    }

   

}
