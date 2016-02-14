//
//  TweetCell.swift
//  Twitter
//
//  Created by Oranuch on 2/12/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    //@IBOutlet weak var tagLineLabel: UILabel!

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var isFavButtonOn: Bool = false
    var isRetweetButtonOn: Bool = false

    
    @IBOutlet weak var favCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text!
//            favCountLabel.text = user.favCount

           
//            nameLabel.text = business.name
//            if business.imageURL != nil {
//                thumbImageView.setImageWithURL(business.imageURL!)
//            }
//            catagoriesLabel.text = business.categories
//            addressLabel.text = business.fullAddress
//            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
//            ratingImageView.setImageWithURL(business.ratingImageURL!)
//            distanceLabel.text = business.distance
            
        }
    }
    
    var user: User! {
        
        didSet {
            userNameLabel.text = user.name
            screenNameLabel.text = "@\(user.screenName!)"
            //tagLineLabel.text = user.tagline
            print(user.profileImageUrl)
            let url = NSURL( string: user.profileImageUrl! )

            if let url = url {
               userImageView.setImageWithURL( url )
            }

            //favCountLabel.text = "\(user.favCount)"
            favCountLabel.text = "\(user.favCount)"
            retweetCountLabel.text = "\(tweet.retweetCount)"

        }
    }
    
    
    @IBAction func onRetweetPress(sender: AnyObject) {
        if isRetweetButtonOn {
            retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
            tweet.retweetCount--
            isRetweetButtonOn = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
            tweet.retweetCount++
            isRetweetButtonOn = true
        }
        retweetCountLabel.text = "\(tweet.retweetCount)"
    }
    
    @IBAction func onFavouritePress(sender: AnyObject) {
        if isFavButtonOn {
            favButton.setImage(UIImage(named:"like-action"), forState: UIControlState.Normal)
            isFavButtonOn = false
            user.favCount--
        } else {
            favButton.setImage(UIImage(named:"like-action-on"), forState: UIControlState.Normal)
            isFavButtonOn = true
            user.favCount++
        }
        favCountLabel.text = "\(user.favCount)"
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
