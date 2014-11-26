//
//  Notifications.swift
//  Logr
//
//  Created by Amol Mane on 24/11/14.
//  Copyright (c) 2014 ManeAppWorld. All rights reserved.
//

import Foundation

class Notifications {
    
    var notificationsArray = [NSDate()]
    //var startHour = 8
    //var endHour = 23
    
    /*
    func changeIntervalPreference(hourGap: Int) {
        //gap can be anything from 1 to 24
    
    }

    
    func changeHoursPreference(startHour: Int, endHour: Int) {
        
    }
    */
    
    func createNotificationsArray() {

        notificationsArray.removeAll(keepCapacity: false)
        
        var y = dateToString(NSDate()).year
        var m = dateToString(NSDate()).month
        var d = dateToString(NSDate()).day
        var h = dateToString(NSDate()).hour
        
        var date = stringToDate(year: y, month: m, day: d, hour: h, minutes: 0)
        var date0 = stringToDate(year: y, month: m, day: d, hour: 0, minutes: 0)
        
        println(h)
        println(date)
        println(dateToString(date0).hour)
        println(date0)
        
        for x in 0...2 {
            if (x == 0) {
                for y in 1...(24 - h) {
                    notificationsArray.append(date.dateByAddingTimeInterval(3600 * Double(y)))
                }
            }
            else {
                for y in 9...24 {
                    notificationsArray.append(date0.dateByAddingTimeInterval((86400 * Double(x))+(3600 * Double(y))))
                }
            }
        }
    }
    
    func stringToDate(#year:Int, month:Int, day:Int, hour:Int, minutes: Int) -> NSDate {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        c.hour = hour
        c.minute = minutes
        
        var gregorian = NSCalendar(identifier:NSGregorianCalendar)
        var date = gregorian!.dateFromComponents(c)
        return date!
    }
    
    func dateToString (date: NSDate) -> (year: Int, month: Int, day: Int, hour: Int, minutes: Int){
        var calendar = NSCalendar.currentCalendar()
        var c = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        var year = c.year
        var month = c.month
        var day = c.day
        var hour = c.hour
        var minutes = c.minute
        return (year: year, month: month, day: day, hour: hour, minutes: minutes)
    }

    func getNotificationsArray() -> [NSDate] {
        createNotificationsArray()
        return notificationsArray
    }
    

    
    
}


