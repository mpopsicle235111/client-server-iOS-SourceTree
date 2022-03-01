//
//  News.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 04.02.2022.
//

import Foundation


struct PhotoPostInCell {
    let sizes : [Sizes]?
}

//Результирующая модель
struct ModelNews {
    let source_ID: Int?
    let text: String?
    let photo_100: String?
    let name: String
    let date: Int?
    let like: Int?
    let comments: Int?
    let reposts: Int?
    let views: Int?
    
    var photoUrl: String?
    var photoSizes: [Sizes]? //photoSize.last, photoSize.first
    var photoPost: [PhotoPost]?
    
}

struct News: Codable {
    let response: ResponseNews
}


struct ResponseNews: Codable {
    let items: [ItemNews]
    let groups: [Groups]
    let profiles: [Profiles]
}

struct Groups: Codable {
    let id: Int?
    let name: String?
    let photo100: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        
        case photo100 = "photo_100"
        
    }
    
}

struct ItemNews: Codable{
    let text: String?
    let sourceID: Int?
    let date: Int?
    let likes: Likes?
    let comments: Comments?
    let reposts: Reposts?
    let views: Views?
    let attachments: [Attachment]?
    
    //    var photoSize: Sizes? {
    //        return attachments.photo?.sizes.last
    //    }
    
    
    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date
        case text
        case likes
        case comments
        case reposts
        case views
        case attachments
        
    }
}

struct Attachment: Codable {
    let photo : PhotoPost?
    
}

struct PhotoPost: Codable {
    
    let sizes : [Sizes]
    
}

struct Sizes: Codable {
    let type: String
    let url: String
    let width: Int
    let height: Int
}

/*
 https://sun9-69.userapi.com/impg/u2-__1E5PgVYJJUaA6NONG6_U80I-GyvNsQxWQ/5MH3E-LUXUs.jpg?size=873x1080&quality=96&sign=18b72da21276c829a1c515601d24d09f&c_uniq_tag=78cSmyIXfgvY-gcSyMqbkn6nvMoNZSaOqav1mBQS6yY&type=album"), width: Optional(873), height: Optional(1080))]))
 
 height - 1000 = 1,15
 width - 873 = 1
 
 aspectRatio = 1,15
 
 widthScreen = widhtPhoto -> 1
 heightPhoto
 
 cell = photo.width = screen.width
 cell = photo.height = photo.width * aspectRation
 
 */

struct PhotoNews: Codable {
    let type: String?
    let url: String?
    let width: Int?
    let height: Int?
    
    
}

struct Views: Codable {
    let count: Int
}


struct Reposts: Codable {
    let count, userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

struct Comments: Codable {
    let canPost, count: Int
    
    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count
    }
}

struct Profiles: Codable {
    let id: Int
    let firstName: String?
    let lastName: String?
    let photo_100: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo_100 = "photo_100"
    }
}

struct Likes: Codable {
    let canLike, count, userLikes, canPublish: Int
    
    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}
