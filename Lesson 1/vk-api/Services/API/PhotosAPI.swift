//
//  PhotosAPI.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 24.12.2021.
//

import Foundation
import Alamofire

/// Temporary plug
struct Photo {
    var name = "Kisa"
}

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
       let params: [String: String] = [
            "user_id": userId,
            "album_id": "wall",
            "count": "5",
            "access_token": accessToken,
            "v": version
            ]
          //We send a request to server using Alamofire
        AF.request(url, method: .get, parameters: params).responseJSON { response in
           
                
//                let photosArray = ["response"]["items"].arrayValue
//                var userPhotos: [String] = []
//                for sizes in photosArray {
//                    let onlyOneType = sizes["sizes"].arrayValue.filter({$0["type"] == "s"})
//                    for url in onlyOneType {
//                        userPhotos.append(url["url"].stringValue)
//                    }
//                }
//                completion(.success(userPhotos))
//                
//            case .failure(let error):
//                print(error)
//                completion(.failure(error))
//            }
//        }
            //print(response.result)

           print(response.data?.prettyJSON)
//            //We unpack optional binary here
//            guard let jsonData = response.data else { return }
//
//            //In this variant "try?" can not throw errors
//            //So when some fields are missing,
//            //the whole table displays nothing
//            //let friendsContainer  = try?  JSONDecoder().decode(FriendsContainer.self,
//            //    from: jsonData)
//
//            //So we need a try/catch block here:
//            do {
//                let photosContainer = try  JSONDecoder().decode(PhotosContainer.self, from: jsonData)
//                let photos = photosContainer.response.items
//
//                completion(photos)
//            } catch {
//                print(error)
//            }
//            }
//
//
//
//
//
//        }
        
        completion([Photo()])
        
    }
    
}

}
