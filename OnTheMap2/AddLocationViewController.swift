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
        
    }
    
    func dismissButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

   

}
