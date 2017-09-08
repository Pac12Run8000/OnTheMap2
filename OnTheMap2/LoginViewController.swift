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

        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Either email or password fields are missing.")
            showAlert(messageText: "Either email or password fields are missing.")
            return
        }
        
        if checkForValidEmailAndPassword(email: email, password: password) {
            UdacityAPIClient.sharedInstance().authenticateUdacityUser(email, password) { (success, errMsg) in
                
                    UdacityAPIClient.sharedInstance().getPublicUserData(completionForGettingPublicUser: { (success, errMsg) in
                    
                        ParseAPIClient.sharedInstance().getStudentLocation(completionHandlerToGetUserLocation: { (success, errMsg) in
                            
                            ParseAPIClient.sharedInstance().getStudentLocations(completionHandlerToGetLocations: { (success, errMsg) in
                                
                            })
                            
                            performUIUpdatesOnMain {
                                
                                let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationsTabBarController")
                                self.present(controller!, animated: true, completion: nil)
                            }
                            
                            
                        })
                    
                    })
            }
            
        }
        
    }
    
    
    func checkForValidEmailAndPassword(email:String, password:String) -> Bool {
        if (email.isEmpty || email == "" || !isEmailAddressValid(emailValue: email)) {
            showAlert(messageText: "Please enter an email.")
            return false
        } else if (password.isEmpty || password == "") {
            showAlert(messageText: "Please enter a password.")
            return false
        }
        return true
    }
    
    func showAlert(messageText:String) {
        let alert = UIAlertController(title: "", message: messageText, preferredStyle: .alert)
        
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true , completion: nil)
    }
    
    func isEmailAddressValid(emailValue:String) -> Bool {
        var isValid = true
        let regExpression = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regEx = try NSRegularExpression(pattern: regExpression)
            let nsString = emailValue as NSString
            let results = regEx.matches(in: emailValue, range: NSRange(location: 0, length: nsString.length))
            
            if (results.count == 0) {
                isValid = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            isValid = false
        }
        return isValid
    }
    
    
    
    
    

    func setUpButton() {
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 6
    }


}

