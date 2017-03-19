//
//  DateConstants.swift
//  Bullet
//
//  Created by Andrew Jiang on 3/17/17.
//  Copyright © 2017 Andrew Jiang. All rights reserved.
//

import Foundation

class DateConstants {
    
    enum DayOfWeek {
        case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
    class var dateFormatter: DateFormatter! {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
    
    static let calendar: Calendar! = Calendar.current
    
    static func getFormattedString(of date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    static func getDateComponents(of date: Date) -> DateComponents {
        let componentOptions: Set<Calendar.Component> = [.day, .month, .year]
        let dateComponents = calendar.dateComponents(componentOptions, from: date)
        return dateComponents
    }
    
    static func getDateWeekComponents(of date: Date) -> DateComponents {
        let componentOptions: Set<Calendar.Component> = [.weekday, .weekdayOrdinal, .weekOfMonth, .weekOfYear]
        let dateComponents = calendar.dateComponents(componentOptions, from: date)
        return dateComponents
    }
    
    static func getDateTimeComponents(of date: Date) -> DateComponents {
        let componentOptions: Set<Calendar.Component> = [.hour, .minute, .second, .nanosecond, .timeZone]
        let dateComponents = calendar.dateComponents(componentOptions, from: date)
        return dateComponents
    }
    
    static func getDayOfWeek(of date: Date) -> DayOfWeek? {
        if let dayOfWeek = getDateWeekComponents(of: date).weekday as Int! {
            switch dayOfWeek {
            case 1: return .sunday
            case 2: return .monday
            case 3: return .tuesday
            case 4: return .wednesday
            case 5: return .thursday
            case 6: return .friday
            case 7: return .saturday
            default: break
            }
        }
        return nil
    }
    
    static func getDayOfWeekString(of date: Date) -> String? {
        if let dayOfWeek = getDayOfWeek(of: date) {
            switch dayOfWeek {
            case .sunday: return "Sunday"
            case .monday: return "Monday"
            case .tuesday: return "Tuesday"
            case .wednesday: return "Wednesday"
            case .thursday: return "Thursday"
            case .friday: return "Friday"
            case .saturday: return "Saturday"
            }
        }
        return nil
    }
    
}
