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
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text!

           
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
            
            

            
        }
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
