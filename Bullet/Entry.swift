//
//  Entries.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/17/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import Foundation

class Entry: NSObject, NSCoding {
    
    enum EntryType {
        case paragraph
        case notes
        case task, completedTask
        case event
    }
    
    var type: EntryType!
    var text: String!
    var isHidden: Bool = false
    
    override init() {
        type = .paragraph
        text = ""
    }
    
    init(type: EntryType, text: String) {
        self.type = type
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        type = aDecoder.decodeObject(forKey: "type") as? EntryType ?? .paragraph
        text = aDecoder.decodeObject(forKey: "text") as? String ?? ""
        isHidden = aDecoder.decodeBool(forKey: "isHidden")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type, forKey: "type")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(isHidden, forKey: "isHidden")
    }
    
}
