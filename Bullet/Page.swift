//
//  Pages.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/17/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import Foundation

class Page: NSObject, NSCoding {
    
    var title: String!
    var subtitle: String!
    
    var dateCreated: Date!
    var dateLastModified: Date!
    var dateReferenced: Date?
    var isPageIdentifiedByDateReferenced: Bool
    
    var entries: [Entry]
    
    var entriesVisibleOnly: [Entry] {
        return entries.filter({ entry -> Bool in
            return !entry.isHidden
        })
    }
    
    var entriesHiddenOnly: [Entry] {
        return entries.filter({ entry -> Bool in
            return entry.isHidden
        })
    }
    
    override init() {
        dateCreated = Date()
        dateLastModified = dateCreated
        dateReferenced = dateCreated
        isPageIdentifiedByDateReferenced = true
        entries = []
        
        title = DateConstants.getFormattedString(of: dateReferenced!)
        subtitle = DateConstants.getDayOfWeek(of: dateReferenced!).debugDescription.capitalized
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        subtitle = aDecoder.decodeObject(forKey: "subtitle") as? String ?? ""
        dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as? Date ?? Date()
        dateLastModified = aDecoder.decodeObject(forKey: "dateLastModified") as? Date ?? Date()
        dateReferenced = aDecoder.decodeObject(forKey: "dateReferenced") as? Date ?? Date()
        isPageIdentifiedByDateReferenced = aDecoder.decodeBool(forKey: "isPageIdentifiedByDateReferenced")
        entries = aDecoder.decodeObject(forKey: "entries") as? [Entry] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(subtitle, forKey: "subtitle")
        aCoder.encode(dateCreated, forKey: "dateCreated")
        aCoder.encode(dateLastModified, forKey: "dateLastModified")
        aCoder.encode(dateReferenced, forKey: "dateReferenced")
        aCoder.encode(isPageIdentifiedByDateReferenced, forKey: "isPageIdentifiedByDateReferenced")
        aCoder.encode(entries, forKey: "entries")
    }
    
}
