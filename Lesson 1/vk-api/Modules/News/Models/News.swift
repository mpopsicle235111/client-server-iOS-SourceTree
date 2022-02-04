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


