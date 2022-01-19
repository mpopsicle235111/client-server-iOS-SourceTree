//
//  FriendDB.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 31.12.2021.
//

import Foundation
import RealmSwift

class FriendDAO: Object, Codable {
        @objc dynamic var id: Int = 0
        @objc dynamic var photo100: String
        @objc dynamic var lastName: String
        @objc dynamic var photo50: String
        @objc dynamic var firstName: String
    
        //These items will not be stored in Realm
        let domain: String
        let trackCode: String
        let isClosed: Bool
        

        enum CodingKeys: String, CodingKey {
            case domain, id
            case photo100 = "photo_100"
            case lastName = "last_name"
            case photo50 = "photo_50"
            case trackCode = "track_code"
            case isClosed = "is_closed"
            case firstName = "first_name"
        }
    }
    
    //It is recommended to process urls like this (Variant 1):
    //@objc dynamic var photoUrl = ""
    
    //Variant 2:
    //var photo: String {
    //       retrun sizes.first.url
    //}
    //Both variants can be used in one code
    
    //It is better NOT to connect one class to another.
    //E.g. Friend 1's pet should not be Friend 2's pet, too
    //If there are no interconnections, Realm works much faster
    


final class FriendsDB {

    //Migration is built in initialization
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15)
    }

    /// Save friends to Realm
    func save(_ items: [FriendDAO]) {
        let realm = try! Realm()

        //Here we input the array asinchronously
        //Because we have a separate Realm for each func
        //This is a safer way
        try! realm.write {
            realm.add(items)
        }
    }

    /// Fetch friends from Realm
    func fetch() -> Results<FriendDAO> {
        let realm = try! Realm()

        //Results is, actually, an array, that Realm returns us
        let friends: Results<FriendDAO> = realm.objects(FriendDAO.self)

        //Actualy we can convert friends to a regular Swift array if necessary
        //Array(friends)

        return friends
    }

    /// Delete friends from Realm
    func delete(_ item: FriendDAO) {
        let realm = try! Realm()

        //This is also asinchronous transaction
        try! realm.write {
            realm.delete(item)
        }
    }
    
    /// Delete all elements - before the fresh start
    func deleteAll() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        }
    
    
}

