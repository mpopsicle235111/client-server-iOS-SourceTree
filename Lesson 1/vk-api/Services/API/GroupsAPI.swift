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
    
    //This is for Internet fetching
    //func getGroups(completion: @escaping([Group])->()) {
    
    //This is for Realm
    func getGroups(completion: @escaping([GroupDAO])->()) {
        
       let path = "/groups.get"
       let url = baseUrl + path
   
       //items is a dictionary
       let groupParams: [String: String] = [
            "used_id": userId,
            "access_token": accessToken,
            "extended" : "1", //This is the key parameter: it returns
                              //data on images and names
            "v": version,
        ]
        
    
    //We send a request to server using Alamofire
    AF.request(url, method: .get, parameters: groupParams).responseJSON { response in
        
      //print(response.result)
        print(response.data?.prettyJSON)
      //Then put into quicktype.io
        
        guard let jsonData = response.data else { return }
        
        let groupsContainer = try? JSONDecoder().decode(GroupsContainer.self, from: jsonData)
        
        guard let groups = groupsContainer?.response?.items else { return }
        
        completion(groups)
    }
           
            
//            MARK: THIS IS MANUAL PARSING
//            do {
//                let jsonContainer: Any = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//                
//                //Force unwrap here is on purpose
//                //so we can better track errors
//                let jsonObject = jsonContainer as! [String: Any]
//                let response = jsonObject["response"] as! [String: Any]
//                let items = response["items"] as! [Any]
//                
//                let groups = items.map { GroupDAO(value: $0 as! // [String: Any])}
//                completion(groups)
//            } catch {
//                print(error)
            }
           
           

}

