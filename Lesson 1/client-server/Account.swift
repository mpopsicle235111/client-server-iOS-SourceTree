//
//  Account.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 10.12.2021.
//

import Foundation

/// This is our singletone - a finall class, can not be inherited - on purpose!
final class Account {
    
    
    /// We need to close our account so it is a Singletone
    private init() {}
    
    /// Static constant - single exemplar. Shared will be stored in static memory.
    static let shared = Account()
    
    var name: String = ""
    var cash: Int = 0
    
}
