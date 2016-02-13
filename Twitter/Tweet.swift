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

    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAtDate = formatter.dateFromString(createdAtString!)
        createdAt = formatter.stringFromDate(createdAtDate!)



    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        return array.map{ Tweet(dictionary: $0) }
    }
}
