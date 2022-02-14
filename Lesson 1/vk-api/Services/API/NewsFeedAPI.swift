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

class NewsFeedAPI {
    
    let baseURL = "https://api.vk.com/method"
    
    func newsRequest (complition: @escaping ([ModelNews] , [PhotoPost]) -> ()) {
        let method = "/newsfeed.get"
        let url = baseURL + method
        let params : [String: Any] = ["user_id": Session.shared.userId,
                                      "access_token": Session.shared.token,
                                      "filters": "post , photo , photo_tag , wall_photo , friend , note , audio , video",
                                      "return_banned":"1",
                                      "max_photos": "100",
                                      "source_ids": "friends , groups , pages, following",
                                      "fields":"name , photo_100 , first_name , last_name",
                                      "count" : "100",
                                      "v": "5.131"
        ]
        
        AF.request(url, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else { return}
            
            let decoder = JSONDecoder()
            
            let dispatchGroup = DispatchGroup()
            
            var arrayNews: [ItemNews] = []
            var arrayGroups: [Groups] = []
            var arrayProfiles:[Profiles] = []
            let newsItem = JSON(data)["response"]["items"].arrayValue
            let groupNews = JSON(data)["response"]["groups"].arrayValue
            let profileNews = JSON(data)["response"]["profiles"].arrayValue
            
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index , items) in newsItem.enumerated() {
                    do {
                        
                        let decodeItem = try decoder.decode(ItemNews.self, from: items.rawData())
                        arrayNews.append(decodeItem)
                        
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, groups) in groupNews.enumerated() {
                    
                    do {
                        let decodeGroup = try decoder.decode(Groups.self, from: groups.rawData())
                        arrayGroups.append(decodeGroup)
                        
                    } catch (let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
                
            }
            
            DispatchQueue.global().async(group: dispatchGroup) {
                for (index, profiles) in profileNews.enumerated() {
                    do {
                        let profiles = try decoder.decode(Profiles.self, from: profiles.rawData())
                        arrayProfiles.append(profiles)
                    } catch(let errorDecode) {
                        print("Item decoding error at index \(index), err: \(errorDecode)")
                    }
                }
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                
                var resp: [ModelNews] = []
                var photoPost: [PhotoPost] = []
                
                for item in arrayNews {
                    if item.sourceID! < 0  {
                        
                        let group = arrayGroups.first{-($0.id!) == item.sourceID}
                        
                        var resultModel = ModelNews(source_ID: item.sourceID, text: item.text, photo_100: group?.photo100, name: group?.name ?? "no name", date: item.date, like: item.likes?.count, comments: item.comments?.count, reposts: item.reposts?.count, views: item.views?.count)
                        
                        
                        item.attachments?.forEach {
                            
                            guard let post = $0.photo else {return}
                            photoPost.append(post)
                            print(post)
                            
                            resultModel.photoSizes = post.sizes
                        }
                        
                        
                        
                        //url-photo
                        //
                        
                        
                        resp.append(resultModel)
                        
                    }
                    
                    else {
                        
                        let a = arrayProfiles.first{$0.id == item.sourceID}
                        
                        let response = ModelNews(source_ID: item.sourceID, text: item.text, photo_100: a?.photo_100!, name: a?.lastName ?? "no name1", date: item.date, like: item.likes?.count, comments: item.comments?.count, reposts: item.reposts?.count, views: item.views?.count, photoUrl: nil, photoSizes: nil)
                        
                        item.attachments?.forEach({
                            guard let post = $0.photo else {return}
                            photoPost.append(post)
                        })
                        
                        resp.append(response)
                    }
                }
                
                
                complition (resp , photoPost)
                
            }
        }
    }
}
