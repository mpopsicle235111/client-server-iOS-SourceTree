//
//  GroupDB.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 31.12.2021.
//

import Foundation
import RealmSwift



// MARK: - Item
final class GroupDAO: Object, Codable {
    //These items will be stored in Realm
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var photo100: String = ""
    
    //These items will not be stored in Realm
    let photo50, photo200: String
    let isAdvertiser, isAdmin: Int
    let isClosed: Int
    let isMember: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case name
        case isClosed = "is_closed"
    }
}




final class GroupsDB {

    //Migration is built in initialization
    init() {
       Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 15)
    }

    /// Save groups to Realm
    func save(_ items: [GroupDAO]) {
        let realm = try! Realm()

        //Here we input the array asinchronously
        //Because we have a separate Realm for each func
        //This is safer way
        try! realm.write {
            realm.add(items)
        }
    }

    /// Fetch groups from Realm
    func fetch() -> Results<GroupDAO> {
        let realm = try! Realm()

        //Results is, actually, an array, that Realm returns us
        let groups: Results<GroupDAO> = realm.objects(GroupDAO.self)

        //Actualy we can convert groups to a regular Swift array if necessary
        //Array(groups)

        return groups
    }

    /// Delete groups from Realm
    func delete(_ item: GroupDAO) {
        let realm = try! Realm()

        //This is also asinchronous transaction
        try! realm.write {
            realm.delete(item)
        }
    }

    /// Delete all elements - before the fresh start
    func deleteAll() {
        let realm = try! Realm()
            realm.deleteAll()
        }
}
