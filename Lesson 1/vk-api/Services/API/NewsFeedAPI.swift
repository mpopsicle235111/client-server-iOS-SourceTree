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
   
       //items is a dictionary
       let newsParams: [String: String] = [
            "access_token": accessToken,
            "user_id": userId,
            "filters" : "post", 
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

