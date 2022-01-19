//
//  Friend.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 23.12.2021.
//

import Foundation
import RealmSwift

// MARK: - FriendsContainer
struct FriendsContainer: Codable {
    let response: FriendsResponse
}

//MARK: - Response
struct FriendsResponse: Codable {
    let count: Int
    
    //For Internet
    //let items: [Friend]
    
    //For Realm
    let items: [FriendDAO]
}

/// DAO (Data Access Object) - we take an object from database, not Internet (as in case with DTO)
//class Friend: Object, Codable {
//    @objc dynamic var canAccessClosed: Bool
//    @objc dynamic var id: Int = 0
//    //@objc dynamic var domain: Int = 0
//    //@objc dynamic var city: String = ""
//    @objc dynamic var photo100: String = ""
//    @objc dynamic var lastName: String = ""
//    @objc dynamic var photo50: String = ""
//    @objc dynamic var trackCode: String = ""
//    @objc dynamic var isClosed: Bool
//    @objc dynamic var firstName: String = ""
//
//    enum CodingKeys: String, CodingKey {
//        case canAccessClosed = "can_access_closed"
//        //case domain, city
//        case id
//        case photo100 = "photo_100"
//        case lastName = "last_name"
//        case photo50 = "photo_50"
//        case trackCode = "track_code"
//        case isClosed = "is_closed"
//        case firstName = "first_name"
//    }
//
//}

    
    // MARK: - Item
struct Friend: Codable {
        let canAccessClosed: Bool
        let domain: String
        let city: City
        let id: Int
        let photo100: String
        let lastName: String
        let photo50: String
        let trackCode: String
        let isClosed: Bool
        let firstName: String

        enum CodingKeys: String, CodingKey {
            case canAccessClosed = "can_access_closed"
            case domain, city, id
            case photo100 = "photo_100"
            case lastName = "last_name"
            case photo50 = "photo_50"
            case trackCode = "track_code"
            case isClosed = "is_closed"
            case firstName = "first_name"
        }
    }

//MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}
