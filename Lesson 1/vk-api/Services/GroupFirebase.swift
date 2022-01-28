//
//  GroupFirebase.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 19.01.2022.
//Go to console.firebase.google.com to check what is uploaded
//to Firebase

import Foundation
import Firebase

//This is a reference to container within Firebase
//Which is a singletone
let ref = Database.database().reference(withPath: "Groups")

// MARK: - GroupContainer
struct GroupsFirebaseContainer: Codable {
    let response: GroupsFirebaseResponse?
    let name: String?
    let founded: Int?
    let members: [String]?
}


// MARK: - Response
struct GroupsFirebaseResponse: Codable {
    let count: Int
    
    let items: [GroupFirebase]
    
}

struct GroupFirebase: Codable {
    // 1
    //let ref: DatabaseReference
    let id: Int
    let name: String
    let photo100: String
    //var photo200: String
    //let isAdvertiser, isAdmin: Int
    //let isClosed: Int
    //let isMember: Int
 
    enum CodingKeys: String, CodingKey {
        //case isMember = "is_member"
        //case ref
        case id
        case photo100 = "photo_100"
        //case isAdvertiser = "is_advertiser"
        //case isAdmin = "is_admin"
        //case photo50 = "photo_50"
        //case photo200 = "photo_200"
        case name
        //case isClosed = "is_closed"
    }

    //To create object in Firebase
    init(name: String, photo100: String, id: Int) {
        // 2
        self.name = name + "From Firebase "
        self.photo100 = photo100
        //self.isAdvertiser = isAdvertiser
        //self.isMember = isMember
        //self.photo200 = photo200
        //self.isAdmin = isAdmin
        self.id = id
        //self.isClosed = isClosed
        //self.photo50 = photo50

    }
    
    //Snapshot is a container, where Firebase stores data
    //We receive this container from Firebase and parse it
    init?(snapshot: DataSnapshot) {
        // 3
        guard
            //Value is a dictionary, that we have received
            //we parse/typecast zipcode and name
            let value = snapshot.value as? [String: Any],
            let photo100 = value["photo100"] as? String,
            let id = value["id"] as? Int,
            let name = value["name"] as? String else {
                return nil
        }

        //self.ref = snapshot.ref
        self.name = name
        self.photo100 = photo100
        self.id = id
    }
    
    func toAnyObject() -> [String: Any] {
        // 4
        return [
            "name": "From Firebase " + name,
            "photo100": photo100,
            "id": id
        ]
    }



}

func saveToFirebase(_ items: [GroupFirebase]) {
    
    let ref = Database.database().reference(withPath: "Groups")
    var counter: Int = 0
    while counter < items.count {
    let group = items[counter]
   
    let groupContainerRef = ref.child(group.name)
    //Then we load data into the reference
    groupContainerRef.setValue(group.toAnyObject())
    counter = counter + 1
    }
}

//func fetchFromFirebase(_ items: [GroupFirebase]) {
//    
//    //This is how we get data back from Firebase
//    //If something happens in Firebase, we react to it
//    ref.observe(.value, with: { snapshot in
//        print(snapshot.value as Any)
//        
//        var groups: [GroupFirebase] = []
//        //We check each child in snapshot
//        //and add them to groups dictionary
//        for child in snapshot.children {
//            
//            if let snapshot = child as? DataSnapshot, let group = GroupFirebase(snapshot: snapshot) {
//                groups.append(group)
//            }
//        }
//        //We transfer our local groups to external controller
//        //self.groups = groups
//        print("Output from Firebase")
//        print(groups)
//        //let _ = self.groups.map { print($0.name, $0.photo100)}
//    })
//}
