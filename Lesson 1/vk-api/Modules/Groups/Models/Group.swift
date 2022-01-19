//
//  Group.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 24.12.2021.
//

import Foundation
import RealmSwift


// MARK: - GroupContainer
struct GroupsContainer: Codable {
    let response: GroupsResponse?
    let name: String?
    let founded: Int?
    let members: [String]?
}

// MARK: - Response
struct GroupsResponse: Codable {
    let count: Int
    
    //For Internet:
    //let items: [Group]
    
    //For Realm:
    let items: [GroupDAO]
}

// MARK: - Item
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type: TypeEnum
    let screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

enum TypeEnum: String, Codable {
    case group = "group"
    case page = "page"
}



//MARK: THIS IS MANUAL PARSING
//We take necessary values from the list above
/// DAO = Data Access Object for database (opposite to DTO, which is for Internet)

//class GroupDAO: Object, Codable {
//    //Dymanic var can be changed in realtime
//    @objc dynamic var id: Int = 0
//    @objc dynamic var name: String = ""
//    @objc dynamic var photo100: String = ""
//
//    init(item: [String: Any]) {
//        self.id = item["id"] as! Int
//        self.name = item["name"] as! String
//        self.photo100 = item["photo_100"] as! String
        
//    }
//}
