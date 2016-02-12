//
//  TwitterClient.swift
//  Twitter
//


import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "5jhbzY24BbBUI0b4FxSKwzbFB"
let twitterConsumerSecret = "dANhOl8c0rUsuI51rCTXS45CvC62e9jkoFk8J5quvSCrnCgSKR"
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
