//
//  TwitterClient.swift
//  Twitter
//


import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "DFbXqgDyTAphzfNjODluUw9g2"
let twitterConsumerSecret = "xlYIIMyvZH5aJ4X18meyj4ldEe7l3dUbB2iJLICrp2DguS6cKX"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret
            )
        }
        return Static.instance
    }
    
    func hometTimelineWithParams (params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) ->()){
        
        GET("1.1/statuses/home_timeline.json",
            parameters: params,
            success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                
                completion(tweets: tweets, error:nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
            })
    }
    
    func homeTimeline(completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json",
            parameters: nil,
            success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets: tweets, error: nil)
                print("Successfully getting home timeline")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
            })
    }
    
    func postTweet(status: String) {
        let params = ["status": status]
        
        POST("1.1/statuses/update.json",
            parameters: params,
            success: {(operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Posted status: \(status)")
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to post status with text:\(status)")
        })
    }

    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        
        //Fetch request token & refirect to authorization page
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath( "oauth/request_token",
            method: "GET",
            callbackURL: NSURL(string: "cptwitterot://oauth"),
            scope: nil,
            success: { (requestToken:BDBOAuth1Credential!) -> Void in
                print("Got the request token")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                
                UIApplication.sharedApplication().openURL(authURL!)
                
            },
            failure: { (error: NSError!) -> Void in
                print("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
            }
        )
    }
    
    func openURL(url:NSURL){
        
        fetchAccessTokenWithPath( "oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success:
            {
                (accessToken: BDBOAuth1Credential!) -> Void in
                
                print("Got the access token!")
                
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET( "1.1/account/verify_credentials.json",
                    parameters: nil,
                    success:{
                        (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                        let user = User(dictionary: response as! NSDictionary)
                        User.currentUser = user
                        
                        print("user: \(user.name)")
                        self.loginCompletion!(user: user, error: nil)
                    },
                    failure:{
                        (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                        print("error getting current user")
                        self.loginCompletion?(user: nil, error: error)
                })
            },
            failure:
            {
                (error: NSError!) -> Void in
                print("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
            }
        )
    }

}
