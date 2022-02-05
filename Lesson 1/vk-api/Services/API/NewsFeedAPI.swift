//
//  NewsFeedAPI.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 04.02.2022.
//

import Foundation
import Alamofire


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
   func getNews(completion: @escaping([NewsItem])->()) {

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
            //"filters": "post",
        
            //Russia Today's source ID is -40316705
            //"source_ids" : "-40316705",
        
            //
            "source_ids" : "groups",
            
            //Number of news items
            "count": "5",
            "v": version,
            ]
        
    
        //We send a request to server using Alamofire
        AF.request(url, method: .get, parameters: newsParams).responseJSON { response in
        
        print(response.data?.prettyJSON)
        //Then put into quicktype.io
        
        guard let jsonData = response.data else { return }
        
        let newsContainer = try? JSONDecoder().decode(NewsContainer.self, from: jsonData)
        
        guard let news = newsContainer?.response?.items else { return }
        
        completion(news)
        print(news)
        }
           
        
    }
           
           

}

