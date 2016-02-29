//
//  TweetCell.swift
//  Twitter
//
//  Created by Oranuch on 2/12/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit


protocol TweetCellDelegate : class {
    func didReply(tweetCell : TweetCell)
    func didTapProfileImage(tweetcell: TweetCell)
}

class TweetCell: UITableViewCell{
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var timeTweetedLabel: UILabel!
    
    var isFavButtonOn: Bool = false
    var isRetweetButtonOn: Bool = false
    var delegate: TweetCellDelegate?
    
    @IBOutlet weak var favCountLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text!
            timeTweetedLabel.text = tweet.timeInterval!
        }
    }
    
    var user: User! {
        
        didSet {
            userNameLabel.text = user.name
            screenNameLabel.text = "@\(user.screenName!)"

            let url = NSURL( string: user.profileImageUrl! )

            if let url = url {
               userImageView.setImageWithURL( url )
            }
            
            self.userImageView.layer.cornerRadius = 8
            self.userImageView.layer.borderWidth = 3
            self.userImageView.layer.borderColor = UIColor.whiteColor().CGColor
            self.userImageView.clipsToBounds = true

            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
            userImageView.addGestureRecognizer(tapGestureRecognizer)

            favCountLabel.text = "\(user.favCount)"
            retweetCountLabel.text = "\(tweet.retweetCount)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.replyButton.setImage(UIImage(named: "reply-action-pressed_0") as UIImage?, forState: .Selected)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func onReplyPress(sender: AnyObject) {
        print("On Reply Press")
        self.delegate?.didReply(self)
    }
    
    func imageTapped(sender: UITapGestureRecognizer){
        self.delegate?.didTapProfileImage(self)
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
}
