//
//  GroupFirebase.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 19.01.2022.
//Go to console.firebase.google.com to check what is uploaded
//to Firebase

import Foundation
import Firebase

class GroupFirebase {
    // 1
    let name: String
    let photo100: String
    let ref: DatabaseReference?
    
    //To create object in Firebase
    init(name: String, photo100: String) {
        // 2
        self.ref = nil
        self.name = name
        self.photo100 = photo100
    }
    
    //Snapshot is a container, where Firebase stores data
    //We receive this container from Firebase and parse it
    init?(snapshot: DataSnapshot) {
        // 3
        guard
            //Value is a dictionary, that we received
            //we parse/typecast zipcode and name
            let value = snapshot.value as? [String: Any],
            let photo100 = value["photo100"] as? String,
            let name = value["name"] as? String else {
                return nil
        }
        
        self.ref = snapshot.ref
        self.name = name
        self.photo100 = photo100
    }
    
    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "name": name,
            "photo100": photo100
        ]
    }
}
