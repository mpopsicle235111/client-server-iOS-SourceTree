//
//  Group.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 24.12.2021.
//

import Foundation

//MARK: We have taken this JSON responce directly here from output
/*"is_member" : 0,
"id" : 78045913,
"photo_100" : "https:\/\/sun9-88.userapi.com\/s\/v1\/if2\/tuwJ9zqJHr4A3snNWp56gRYUJvkxyCSC59dD72-TKonM3sqYWKCDm2yS7Vsk0gVTWpJwrX9DWskP4K7HdJgEC0wi.jpg?size=100x100&quality=96&crop=41,75,287,287&ava=1",
"is_advertiser" : 0,
"is_admin" : 0,
"photo_50" : "https:\/\/sun9-88.userapi.com\/s\/v1\/if2\/RukF8FE5GDr72lBQ18sRWLKBfOO1xNyu1_bRsi-oO8FQMWRTaOW_rlesdkJd0vNLXVXxYfJnRvqQtcQRhLrCosP_.jpg?size=50x50&quality=96&crop=41,75,287,287&ava=1",
"photo_200" : "https:\/\/sun9-88.userapi.com\/s\/v1\/if2\/uZxNsV1JGt2CXbkqug-kQHKFPaOJWID1K0HLMdESjCr8ll5C5nt-2A3qQK5A6PmIl2xsXm5SRic3ninz-Xz0_I_Y.jpg?size=200x200&quality=96&crop=41,75,287,287&ava=1",
"type" : "group",
"screen_name" : "davydov_official",
"name" : "Константин Давыдов | ОФИЦИАЛЬНАЯ ГРУППА АКТЕРА",
"is_closed" : 0
    
}
*/

//MARK: THIS IS MANUAL PARSING
//We take necessary values from the list above
struct Group {
    var id: Int = 0
    var name: String = ""
    var photo100: String = ""
    
    init(item: [String: Any]) {
        self.id = item["id"] as! Int
        self.name = item["name"] as! String
        self.photo100 = item["photo_100"] as! String
        
    }
}
