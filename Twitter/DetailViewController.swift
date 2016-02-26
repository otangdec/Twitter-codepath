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

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
