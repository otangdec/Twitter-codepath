//
//  DetailViewController.swift
//  Twitter
//
//  Created by Oranuch on 2/13/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tweet: Tweet!
    var user: User!

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetNumberLabel: UILabel!
    @IBOutlet weak var favouriteNumberLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var isFavButtonOn: Bool = false
    var isRetweetButtonOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = user.name
        handleLabel.text = "@\(user.screenName!)"
        let url = NSURL( string: user.profileImageUrl! )
        
        if let url = url {
            userProfileImageView.setImageWithURL( url )
        }
        
        self.userProfileImageView.layer.cornerRadius = 8
        self.userProfileImageView.layer.borderWidth = 3
        self.userProfileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.userProfileImageView.clipsToBounds = true
        
        tweetMessageLabel.text = tweet.text
        dateLabel.text = tweet.createdAt
        
        retweetNumberLabel.text = "\(tweet.retweetCount)"
        favouriteNumberLabel.text = "\(user.favCount)"
    }

    @IBAction func onRetweetPress(sender: AnyObject) {
        if isRetweetButtonOn {
            retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
            tweet.retweetCount!--
            isRetweetButtonOn = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
            tweet.retweetCount!++
            isRetweetButtonOn = true
        }
        retweetNumberLabel.text = "\(tweet.retweetCount)"
    }
    
    @IBAction func onFavouritePress(sender: AnyObject) {
        if isFavButtonOn {
            favouriteButton.setImage(UIImage(named:"like-action"), forState: UIControlState.Normal)
            isFavButtonOn = false
            user.favCount--
        } else {
            favouriteButton.setImage(UIImage(named:"like-action-on"), forState: UIControlState.Normal)
            isFavButtonOn = true
            user.favCount++
        }
        favouriteNumberLabel.text = "\(user.favCount)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "replySegue" {
            let compose = segue.destinationViewController  as! ComposeViewController
            compose.replyToUserScreenName = user.screenName
        }
    }
}
