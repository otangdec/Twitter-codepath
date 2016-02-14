//
//  Tweet.swift
//  Twitter
//
//  Created by Oranuch on 2/12/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAtDate: NSDate?
    var createdAt: String?
    var retweetCount: Int!
    var timeInterval: String!

    
    init(dictionary: NSDictionary){
        
        super.init()
        
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAtDate = formatter.dateFromString(createdAtString!)
        createdAt = formatter.stringFromDate(createdAtDate!)
        retweetCount = dictionary["retweet_count"] as! Int
        timeInterval = calculateTimeInterval(createdAtDate!)
        print(timeInterval)


    }
    
    func calculateTimeInterval(date: NSDate)->String{
        let minInSecs:Double = 60
        let hourInSecs:Double = minInSecs * 60
        let dayInSecs:Double = hourInSecs * 24
        let yearInSecs:Double = dayInSecs * 365
        
        var timeInterval: String!
        let elapsedTime = NSDate().timeIntervalSinceDate(createdAtDate!)
        if elapsedTime >= yearInSecs {
            timeInterval = "\(Int(elapsedTime / yearInSecs))y"
        } else if elapsedTime < yearInSecs && elapsedTime >= dayInSecs {
            timeInterval = "\(Int(elapsedTime / dayInSecs))d"
        } else if elapsedTime < dayInSecs && elapsedTime >= hourInSecs {
            timeInterval = "\(Int(elapsedTime / hourInSecs))h"
        } else if elapsedTime < hourInSecs && elapsedTime >= minInSecs {
            timeInterval = "\(Int(elapsedTime / minInSecs))m"
        } else if elapsedTime < minInSecs {
            timeInterval = "\(Int(elapsedTime))s"
        }
        
        return timeInterval
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        return array.map{ Tweet(dictionary: $0) }
    }
}
