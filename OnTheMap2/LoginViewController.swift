//
//  ViewController.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButton()
        
        
       
    }
    
    @IBAction func loginButtonPress(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationsTabBarController") as! UITabBarController
        present(controller, animated: true, completion: nil)
        
        
        
        
    }
    
    
    

    func setUpButton() {
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 6
    }


}

