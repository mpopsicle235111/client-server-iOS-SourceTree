//
//  HomeViewController.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 18.01.2022.
//
//Go to console.firebase.google.com to check what is uploaded
//to Firebase

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let authService = Auth.auth()
    
    //This is a reference to container within Firebase
    //Which is a singletone
    let ref = Database.database().reference(withPath: "Groups")
    
    var groups: [GroupFirebase] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is how we get data back from Firebase
        //If something happens in Firebase, we react to it
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
            
            var groups: [GroupFirebase] = []
            //We check each child in snapshot
            //and add them to groups dictionary
            for child in snapshot.children {
                
                if let snapshot = child as? DataSnapshot, let group = GroupFirebase(snapshot: snapshot) {
                    groups.append(group)
                }
            }
            //We transfer our local groups to external controller
            self.groups = groups
            print("Output from Firebase")
            let _ = self.groups.map { print($0.name, $0.photo100)}
        })
        
    }
    
    //"Logout from Firebase" button
    @IBAction func signOutAction(_ sender: Any) {
        //This function (authService.signOut) throws, so we have to do "try"
        try? authService.signOut()
        //After we sign out, we go to the previous screen (FirebaseLoginViewController)
       showFirebaseLoginViewController()
        }
        
    
    
    private func showFirebaseLoginViewController() {
        //If there is such controller, we want to unload it
        guard let vc3 = storyboard?.instantiateViewController(withIdentifier: "FirebaseLoginViewController") else { return }
        //All controllers are contained in window
        //To show controller we add it to the window
        guard let window = self.view.window else { return }
        window.rootViewController = vc3
    
    }
    
    
    //"Add group to Firebase" button
    @IBAction func addGroupAction(_ sender: Any) {
        //First we create a container
        let group = GroupFirebase(name: "NESTEA", photo100: "https://sun9-27.userapi.com/s/v1/if1/SZL9inn5MKPaUY78wuw_4t7D84HVV0m_6Vmw94Gb1LNlQ-dwddWbioBkiTl8YbJydcUYVtAE.jpg?size=100x100&quality=96&crop=0,0,500,500&ava=1")
        //Then we make it ready to save
        let groupContainerRef = self.ref.child(group.name)
        //Then we load data into the reference
        groupContainerRef.setValue(group.toAnyObject())
       
        //Go to console.firebase.google.com to check, what is uploaded
        //to firebase
    }
    
    
}
