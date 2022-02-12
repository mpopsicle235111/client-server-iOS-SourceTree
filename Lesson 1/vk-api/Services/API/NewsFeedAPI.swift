//
//  NewsFeedAPI.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 04.02.2022.
//

import Foundation
import Alamofire
import SwiftyJSON //This is necessary for JSON variable


/// This is a temporary plug
//struct NewsItem {
//   var name = "Britney shaved her head"
//   }

//This is VK API's request structure
//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V

final class NewsFeedAPI {
    
   let baseUrl = "https://api.vk.com/method"
   let userId = Session.shared.userId
   let accessToken = Session.shared.token
   let version = "5.131"
    
   //This is for Internet fetching
   func getNews(completion: @escaping([ResponseItem])->()) {

       let path = "/newsfeed.get"
       let url = baseUrl + path
   
       //NOTE: IN ORDER TO HAVE ACCESS TO NEWSFEED
       //one needs access BOTH to Friends AND WALL
       //permitted in Authentification Controller
       //This is a weird trick by VK
       let newsParams: [String: String] = [
            "access_token": accessToken,
            "user_id": userId,
            //Use this ine to get ids for the groups
            "filters": "post, photo, wall_phoo, friend, note, audio, video",
            "max_photos": "5",
            //Russia Today's source ID is -40316705
            //"source_ids" : "-40316705",
        
            //"source_ids" : "groups",
            
            //Number of news items
            //"count": "5",
            "v": version,
            ]
        
    
        //We send a request to server using Alamofire
        AF.request(url, method: .get, parameters: newsParams).responseJSON { response in
        
        print(response.data?.prettyJSON)
        //Then put into quicktype.io
        
        guard let jsonData = response.data else { return }
        
        let decoder = JSONDecoder()
        let json = JSON(jsonData)
        let dispatchGroup = DispatchGroup()
        
        let vkItemsJSONArray = json["response"]["items"].arrayValue
        let vkProfilesJSONArray = json["response"]["profiles"].arrayValue
        let vkGroupsJSONArray = json["response"]["groups"].arrayValue
            
        var vkItemsArray: [ResponseItem] = []
        var vkGroupsArray: [GroupItem] = []
        var vkProfilesArray: [Profile] = []
         
        //This is parallel decoding using DispatchQueue
        //MARK: Separately decoding items
            DispatchQueue.global().async(group: dispatchGroup){
                for (index, items) in vkItemsJSONArray.enumerated(){
                    do {
                        let decodedItem = try decoder.decode(ResponseItem.self, from: items.rawData())
                        vkItemsArray.append(decodedItem)
                    } catch {
                        print("ResponseItem decoder error at index \(index), err: \(error)")
                    }
                }
            }
            print("===========")
            print("This is vkItemsArray")
            sleep(2)
            print(vkItemsArray)
            print("===========")
            sleep(2)
            
            //MARK: Separately decoding Profiles
                DispatchQueue.global().async(group: dispatchGroup){
                    for (index, profiles) in vkItemsJSONArray.enumerated(){
                        do {
                            let decodedItem = try decoder.decode(Profile.self, from: profiles.rawData())
                            vkProfilesArray.append(decodedItem)
                        } catch {
                            print("Profile decoder error at index \(index), err: \(error)")
                        }
                    }
                }
                print("===========")
                print("This is vkProfilesArray")
                sleep(2)
                print(vkProfilesArray)
                print("===========")
            
            //MARK: Separately decoding GroupItems
                DispatchQueue.global().async(group: dispatchGroup){
                    for (index, groups) in vkItemsJSONArray.enumerated(){
                        do {
                            let decodedItem = try decoder.decode(GroupItem.self, from: groups.rawData())
                            vkGroupsArray.append(decodedItem)
                        } catch {
                            print("GroupItem decoder error at index \(index), err: \(error)")
                        }
                    }
                }
                print("===========")
                print("This is vkGroupItemsArray")
                sleep(2)
                print(vkGroupsArray)
                print("===========")
            
                //Finalize the parallel parsing process
                //Combine parsed items into one array
            dispatchGroup.notify(queue: DispatchQueue.main) {
//                let response = FeedResponse(items: vkItemsArray,
//                                            groups: vkGroupsArray,
//                                            profiles: vkProfilesArray
//                                            )
//                let newsFeed = NewsFeed(response: response)
                let response = vkItemsArray
                completion(response)
            }
            
        }
           
        
    }
           
           

}

