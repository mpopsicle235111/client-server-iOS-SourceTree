//
//  News.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 04.02.2022.
//

import Foundation


// MARK: - NewsContainer
struct NewsContainer: Codable {
    let response: NewsResponse?
   
}

// MARK: - Response
struct NewsResponse: Codable {
   
    let items: [NewsItem]

    
}


struct NewsItem: Codable {
   var name = "Britney shaved her head"
   }



// MARK: - Response
struct Response: Codable {
    let items: [ResponseItem]
    let groups: [GroupItem]
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct GroupItem: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
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

// MARK: - ResponseItem
struct ResponseItem: Codable {
    let donut: Donut?
    let comments: Comments?
    let canSetCategory, isFavorite: Bool?
    let shortTextRate: Double?
    let likes: PurpleLikes?
    let reposts: Reposts?
    let type: String
    let postType: String?
    let date, sourceID: Int
    let text: String?
    let canDoubtCategory: Bool?
    let attachments: [Attachment]?
    let markedAsAds: Int?
    let postID: Int
    let postSource: PostSource?
    let views: Views?
    let photos: Photos?

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case postSource = "post_source"
        case views, photos
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: PhotoItem
}

// MARK: - Photo
struct PhotoItem: Codable {
    let albumID, postID, id, date: Int
    let text: String
    let userID: Int
    //let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text
        case userID = "user_id"
        //case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
    }
}

// MARK: - Size
//struct Size: Codable {
//    let width, height: Int
//    let url: String
//    let type: String
//}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - PurpleLikes
struct PurpleLikes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [PhotosItem]
}

// MARK: - PhotosItem
struct PhotosItem: Codable {
    let id: Int
    let comments: Views
    let likes: FluffyLikes
    let accessKey: String
    let userID: Int
    let reposts: Reposts
    let date, ownerID, postID: Int
    let text: String
    let canRepost: Int
    let sizes: [Size]
    let hasTags: Bool
    let albumID, canComment: Int

    enum CodingKeys: String, CodingKey {
        case id, comments, likes
        case accessKey = "access_key"
        case userID = "user_id"
        case reposts, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text
        case canRepost = "can_repost"
        case sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - FluffyLikes
struct FluffyLikes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Profile
struct Profile: Codable {
    let canAccessClosed: Bool
    let screenName: String
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
    }
}



struct NewsPost {
     var postId: Int
     var date: String
     var author: String
     var text: String
     var photo: String
     var comments: Int
     var likes: Int
     var views: Int
     var repost: Int
 }

 let demoNews = [
     NewsPost(
         postId: 1,
         date: "01.12.2021",
         author: "Иванов Иван",
         text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
         photo: "News1-img.jpg",
         comments: 20,
         likes: 10,
         views: 500,
         repost: 3
     ),
     NewsPost(
         postId: 2,
         date: "05.01.2022",
         author: "Петров Петр",
         text: "",
         photo: "Heart-img.jpg",
         comments: 12,
         likes: 33,
         views: 30,
         repost: 10
     ),
     NewsPost(
         postId: 3,
         date: "30.01.2022",
         author: "Сидоров Андрей",
         text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
         photo: "GHeart-img.jpg",
         comments: 232,
         likes: 211,
         views: 44232,
         repost: 4435
     ),
 ]

 enum CellType {
     case photo
     case text
 }

 struct NewsDataRow {
     var type: CellType
     var photo: String?
     var text: String?
 }

 struct NewsSection {
     var postId: Int
     var date: String
     var author: String
     var comments: Int
     var likes: Int
     var views: Int
     var reposts: Int
     var data: [NewsDataRow]
 }

 extension NewsSection {
     var authorPhoto: String {
         return "author-\(postId)"
     }
 }

struct NewsFeed  {
     //    let canDoubtCategory, isArchived: Bool?
     //    let postID: Int
     //    let likes: PurpleLikes?
     //    let isFavorite: Bool?
     //    let views: Views?
     //    let canSetCategory: Bool?
     //    let sourceID: Int
     //    let type: String
     let date: String
     //    let shortTextRate: Double?
     //    let canEdit: Int?
     //    let canArchive: Bool?
     //    let attachments: [Attachment]?
     //    let postSource: PostSource?
     //    let postType: String?
     //    let reposts: FluffyReposts?
     let text: String?
     //    let comments: Comments?
     //    let donut: Donut?
     let canDelete: Int?
     //    let photos: Photos?
 }
