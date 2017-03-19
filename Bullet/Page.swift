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
    
    override var hashValue: Int {
        return dateCreated.hashValue
    }
    
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
    
    func insertVisibleEntryAfter(_ newEntry: Entry, at index: Int) {
        let entriesVisibleOnly = self.entriesVisibleOnly
        if index < entriesVisibleOnly.count {
            let existingEntry = entriesVisibleOnly[index]
            if let existingEntryIndex = entries.index(of: existingEntry) {
                let newEntryIndex = entries.index(after: existingEntryIndex)
                entries.insert(newEntry, at: newEntryIndex)
                return
            }
        }
        entries.append(newEntry)
    }
    
    func insertHiddenEntryAfter(_ newEntry: Entry, at index: Int) {
        let entriesHiddenOnly = self.entriesHiddenOnly
        if index < entriesHiddenOnly.count {
            let existingEntry = entriesHiddenOnly[index]
            if let existingEntryIndex = entries.index(of: existingEntry) {
                let newEntryIndex = entries.index(after: existingEntryIndex)
                entries.insert(newEntry, at: newEntryIndex)
                return
            }
        }
        entries.append(newEntry)
    }
    
    func removeEntry(_ entry: Entry) {
        if let entryIndex = entries.index(of: entry) {
            entries.remove(at: entryIndex)
        }
    }
    
    override init() {
        dateCreated = Date()
        dateLastModified = dateCreated
        dateReferenced = dateCreated
        isPageIdentifiedByDateReferenced = true
        entries = []
        
        title = DateConstants.getFormattedString(of: dateReferenced!)
        subtitle = DateConstants.getDayOfWeekString(of: dateReferenced!)
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
