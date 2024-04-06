//
//  Date_Extension.swift
//  CodeCat Swift ui
//
//  Created by Jigar Shethia on 05/04/24.
//

import Foundation
extension Date {
    func toString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .short
        dateformatter.timeStyle = .short
        
        return dateformatter.string(from: self)
    }
    
}
