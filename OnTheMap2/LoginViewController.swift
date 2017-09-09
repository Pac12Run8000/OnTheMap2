//
//  ViewController.swift
//  OnTheMap2
//
//  Created by Michelle Grover on 9/6/17.
//  Copyright © 2017 Norbert Grover. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpButton()
        setUpActivityView()
       
    }
    
    func setUpActivityView() {
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.view.addSubview(self.activityIndicator)
    }
    
    
    
    @IBAction func loginButtonPress(_ sender: Any) {
        
        self.activityIndicator.startAnimating()
        self.setUIEnabled(false)

        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Either email or password fields are missing.")
            showAlert(messageText: "Either email or password fields are missing.")
            return
        }
        
        if checkForValidEmailAndPassword(email: email, password: password) {
            UdacityAPIClient.sharedInstance().authenticateUdacityUser(email, password) { (success, errMsg) in
                if (!success) {
                    performUIUpdatesOnMain {
                        self.setUIEnabled(true)
                        self.activityIndicator.stopAnimating()
                        self.showAlert(messageText: errMsg)
                    }
                }
                
                    UdacityAPIClient.sharedInstance().getPublicUserData(completionForGettingPublicUser: { (success, errMsg) in
                    
                        ParseAPIClient.sharedInstance().getStudentLocation(completionHandlerToGetUserLocation: { (success, errMsg) in
                            
                            ParseAPIClient.sharedInstance().getStudentLocations(completionHandlerToGetLocations: { (success, errMsg) in
                                
                                performUIUpdatesOnMain {
                                    
                                    self.activityIndicator.stopAnimating()
                                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "LocationsTabBarController")
                                    self.present(controller!, animated: true, completion: nil)
                                }
                                
                            })
                            
                        })
                    
                    })
            }
       //this is the auth area
            
        }
        
    }
    
    
    func checkForValidEmailAndPassword(email:String, password:String) -> Bool {
        if (email.isEmpty || email == "" || !isEmailAddressValid(emailValue: email)) {
            activityIndicator.stopAnimating()
            showAlert(messageText: "Please enter an email.")
            return false
        } else if (password.isEmpty || password == "") {
            activityIndicator.stopAnimating()
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
    
    
    func setUIEnabled(_ enabled:Bool) {
        emailTextField.isEnabled = enabled
        passwordTextField.isEnabled = enabled
        loginButton.isEnabled = enabled
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    

    func setUpButton() {
        loginButton.layer.masksToBounds = true
        loginButton.layer.cornerRadius = 6
    }


}

