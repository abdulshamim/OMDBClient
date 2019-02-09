//
//  Extensions.swift
//  OMDBClient
//
//  Created by Abdul Shamim on 09/02/19.
//  Copyright © 2019 Abdul Shamim. All rights reserved.
//

import UIKit

extension Date {
   
    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.year], from: self, to: Date())
       
        var timeAgo = ""
        if let year = interval.year, year > 0 {
            timeAgo = year == 1 ? "\(year)" + " " + "year" : "\(year)" + " " + "years"
        }
        return timeAgo + " ago"
    }
}


extension String {
    //Getting time ago string
    func timeAgo() -> String {
        let localTime = self.convertDateFromUTCtoLocal(input: DateFormatters.serverDateFormat, output: DateFormatters.displayDateFormat)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = DateFormatters.displayDateFormat
        dateFormatter.timeZone = NSTimeZone.local
        let dateObject = dateFormatter.date(from: localTime) ?? Date()
       // print(dateObject.getElapsedInterval())
        return (dateObject.getElapsedInterval() )
    }
    
    
    func convertDateFromUTCtoLocal(input: String, output: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = input
        dateFormatter.timeZone = TimeZone(abbreviation:  "UTC")

        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = output
        dateFormatter.timeZone = NSTimeZone.local
        guard date != nil else {
            return ""
        }
        let timeStamp = dateFormatter.string(from: date!)
        return timeStamp
    }
    
}
