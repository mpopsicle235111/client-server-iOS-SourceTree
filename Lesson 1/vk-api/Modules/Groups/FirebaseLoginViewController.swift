//
//  FirebaseLoginViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 18.01.2022.
//Go to console.firebase.google.com to check what is uploaded
//to Firebase

import UIKit
import Firebase

class FirebaseLoginViewController: UIViewController {
    
    //Login(email) text field
    @IBOutlet weak var emailTextField: UITextField!
    //Password text field
    @IBOutlet weak var passwordTextField: UITextField!
    //This token tracks user state
    //If user is non-nil, this means, the user is authorized
    private var token: AuthStateDidChangeListenerHandle!
    
    //This is the service to authorize us in Firebase
    private let authService = Auth.auth()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This token tracks user state
        //If user is non-nil, this means, the user is authorized
        //Anc can proceed to the next screen, HomeViewController
        token = authService.addStateDidChangeListener({ auth, user in
            
            guard user != nil else { return }
            self.showHomeViewController()
        })
    }
    
    //Sign in (authorization) button
    @IBAction func signInAction(_ sender: Any?) {
        //We extract text from the user data in text field
        //If there is a text - we have text (hence optional)
        //These below are 2 checks: for email and for password to exist
        guard let email = emailTextField.text, emailTextField.hasText,
              let password = passwordTextField.text, passwordTextField.hasText
        //If something is missing we show alert (described below in showAlert func)
        else {
            showAlert(title: "Client error", text: "Login or password is missing")
            return
        }
        //We have set up user in Firebase online console
        //Now we use user email and password to authorize to Firebase
        authService.signIn(withEmail: email, password: password) { authResult, error in
                                                                   
            //If there is a server error, we pop it up with showAlert func
            if let error = error {
                self.showAlert(title: "Server error", text: error.localizedDescription)
                //Return is important, otherwise user proceeds to the next screen anyway
                return
            }
            self.showHomeViewController()
        }
        
    }
    
    
    
    //Sign up (register NEW USER) button
    @IBAction func signUpAction(_ sender: Any) {
        //We extract text from the user data in text field
        //If there is a text - we have text (hence optional)
        //These below are 2 checks: for email and for password to exist
        guard let email = emailTextField.text, emailTextField.hasText,
              let password = passwordTextField.text, passwordTextField.hasText
        //If something is missing we show alert (described below in showAlert func)
        else {
            showAlert(title: "Client error", text: "Login or password is missing")
            return
        }
        
        authService.createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                self.showAlert(title: "Server error", text: error.localizedDescription)
                return //If there are no errors, we create new user
            }
            //After registering the new user, it's reasonable to authorize him/her, so he/she would get instant access
            //So we run the above mentioned signInAction  func
            self.signInAction(nil)
            
        }
    }
    
    
    
    
    //This func is going to hook the HomeViewController via Storyboard ID
    //instead of making segues
    //The Storyboard ID should be set before this for each controller
    //It is private, because it is used only within this current FirebaseLoginViewController
    private func showHomeViewController() {
        //If there is such controller, we wand to unload it
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") else { return }
        //All controllers are contained in window
        //To show controller we add it to the window
        guard let window = self.view.window else { return }
        window.rootViewController = vc
    }
    
    
    @IBAction func getBackToGroups(_ sender: Any) {
        
        self.showGroupsViewController()
    }
    
    private func showGroupsViewController() {
        
       
        
        //If there is such controller, we wand to unload it
        guard let vc2 =
                storyboard?.instantiateViewController(withIdentifier: "MyTabBarController")
                
                 //This one is fun - we get back to VK init screen
                //storyboard?.instantiateInitialViewController()
        
               else { return }
        //This line does the same as guard let windows - but it's
        //less safe, although shorter
        //self.present(vc2, animated: false, completion: nil)
        
        //All controllers are contained in window
        //To show controller we add it to the window
        guard let window = self.view.window else { return }
        window.rootViewController = vc2
        
        
    }
    
    
    
    //We are going to display errors (wrong password, invalid email) via alert
    //Optionals here because the error can be present, or not present
    private func showAlert(title: String?, text: String?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        //This is the OK button, so the user can close alert pop-up window
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        //Now we add OK button to the alert pop-up window
        alert.addAction(ok)
        //Alert is a regular controller, so we modally pop-up it upon the screen
        self.present(alert, animated: false, completion: nil)
    }
    
}
