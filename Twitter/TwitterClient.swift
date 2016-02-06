//
//  TwitterClient.swift
//  Twitter
//
//  Created by Sarn Wattanasri on 2/3/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "o3uZBSbASeCF1L7mFufLDK14o"
let twitterConsumerSecret = "SIdr3EEe3OCx173CpHi9iSSmap9U9BJHikMfcOFsyAGu1SGUBx"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret
            )
        }
        return Static.instance
    }

}
