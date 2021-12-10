//
//  Session.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 11.12.2021.
//

import Foundation

/// This singletone stores data about the current session
final class Session {
    private init() {}
    
    static let shared = Session()
    
    var token = ""// Stores user token in VK
    var userId = 0 // Stores user identifier in VK
    
}
