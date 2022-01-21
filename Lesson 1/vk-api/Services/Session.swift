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
    var userId = "" // Stores user identifier in VK
    
    var expiresIn = "" //TO DO:
                       //VK provides data in UNIX seconds,
                       //how much time the token is still valid
                       //A check can be implemented
                       //how much time the token is still valid
                       //Or maybe it nees refreshment
                       
           
}
