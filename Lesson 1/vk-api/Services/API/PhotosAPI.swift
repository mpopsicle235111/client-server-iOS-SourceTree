//
//  PhotosAPI.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 24.12.2021.
//

import Foundation
import Alamofire

/// Temporary plug
//struct Photo {
//    var name = "Kisa"
//}

//This is VK API's request structure
//We access binary
//https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V


final class PhotosAPI {
   
    let baseUrl = "https://api.vk.com/method"
    let userId = Session.shared.userId
    let accessToken = Session.shared.token
    let version = "5.131"


   /// Through completion handler it transfers closure
    ///which receives Photos array, it is a container, where
    //Photos array is packed into
    func getPhotos(completion: @escaping([Photo])->()) {
   
       let path = "/photos.get"
       let url = baseUrl + path

        //Params is a dictionary
       var photoParams: [String: String] = [
            "user_id": userId,
            "album_id": "wall",
            "count": "20",
            "access_token": accessToken,
            "v": version
            ]

        
       //We send a request to server using Alamofire
        AF.request(url, method: .get, parameters: photoParams).responseJSON { response in

           //print(response.result)
           print(response.data?.prettyJSON)
           //Then put into quicktype.io

           guard let jsonData = response.data else { return }
           
           
           ///MARK: THIS IS QUICKTYPE.IO auto parsing
           let photosContainer = try? JSONDecoder().decode(PhotosContainer.self, from: jsonData)
   
        
           guard let photos = photosContainer?.response?.items else { return }
        
           completion(photos)
        
        
//
//            //Force unwrap here is on purpose
//            //so we can better track errors
//            let array = jsonContainer as! [Any]
//            for userJson in array {
//                let userJson = userJson as! [String: Any]
//                let album_id = userJson["album_id"] as! Int
//                let id = userJson["id"] as! Int
//                let date = userJson["date"] as! Int
//                let text = userJson["text"] as! String
//                      let sizesJson = userJson["sizes"] as! [String: Any]
//                      let width = sizesJson["width"] as! Int
//                      let height = sizesJson["height"] as! Int
//                let url = sizesJson["url"] as! String
//                let type = sizesJson["type"] as! String
//
//
//                print(album_id,id,date,text, width,height,url,type)
//            }
        }
           // completion([Photo()])
        }
}


