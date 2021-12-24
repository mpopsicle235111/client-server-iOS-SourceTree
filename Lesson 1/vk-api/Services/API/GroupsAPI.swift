//
//  GroupsAPI.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 24.12.2021.
//

import Foundation
import Alamofire

/// This is a temporary plug
//struct Group {
//    var name = "Britney fans"
//}

//This is VK API's request structure
//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

final class GroupsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let userId = Session.shared.userId
    let accessToken = Session.shared.token
    let version = "5.131"
    let fields = "decription"
    let extended = "1"
    
    func getGroups(completion: @escaping([Group])->()) {
        
        let path = "/groups.getCatalog"
        let url = baseUrl + path
    
        //Params is a dictionary
        let items: [String: String] = [
            "is_member": "1",
            "id": "group_id",
            "count": "5",
            "photo100": "photo_100",
            "access_token": accessToken,     //"domain" here means User ID
            "v": version
        ]
        //We send a request to server using Alamofire
        AF.request(url, method: .get, parameters: items).responseJSON { response in
        
           // print(response.result)
            print(response.data?.prettyJSON)
            guard let jsonData = response.data else { return }
            
            //MARK: THIS IS MANUAL PARSING
            do {
                let jsonContainer: Any = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                
                //Force unwrap here is on purpose
                //so we can better track errors
                let jsonObject = jsonContainer as! [String: Any]
                let response = jsonObject["response"] as! [String: Any]
                let items = response["items"] as! [Any]
                
                let groups = items.map { Group(item: $0 as! [String: Any])}
                completion(groups)
            } catch {
                print(error)
            }
            
          //  completion([Group()])
        }
    }
}

