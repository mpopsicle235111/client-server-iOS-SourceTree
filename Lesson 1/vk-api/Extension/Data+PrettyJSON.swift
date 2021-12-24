//
//  Data+PrettyJSON.swift
//  Lesson 1
//
//  Created by Anton Lebedev on 23.12.2021.
//

import Foundation

extension Data {
    
    /// NSString gives us a  clean debugDescription
    var prettyJSON: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              
              //We require utf8 encoding and prettyPrinted layout
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        
        return prettyPrintedString
        }
}
