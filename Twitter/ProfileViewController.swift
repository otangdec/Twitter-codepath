//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Oranuch on 2/23/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var userHeaderImageView: UIImageView!
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    
    @IBOutlet weak var numFollowersLabel: UILabel!
    
    @IBOutlet weak var composeButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var editProfileButton: UIButton!
    
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if User.currentUser != nil{
            user = User.currentUser!
            userNameLabel.text = user?.name
            handleLabel.text = "@" + user!.screenName!
            let url = NSURL( string: user!.profileImageUrl! )
            let bgUrl = NSURL( string: user!.profileBGImageUrl!)
            
            if let url = url {
                userProfileImageView.setImageWithURL( url )
            }
            if let bgUrl = bgUrl {
                userHeaderImageView.setImageWithURL(bgUrl)
            }
            
            customizeProfileImage()

            locationLabel.text = user!.location
            
            descriptionLabel.text = user!.userDescription

            setBorder(editProfileButton,borderWidth: 1.0,cornerRadius: 5.0,borderColor: UIColor.grayColor())
            
            numFollowersLabel.text = String(user!.followersCount!)
            
            numFollowingLabel.text = String(user!.followingCount!)
        }
    }
    
    func setBorder(button: UIButton, borderWidth: CGFloat, cornerRadius: CGFloat, borderColor: UIColor){
        button.layer.borderWidth = borderWidth
        button.layer.cornerRadius = cornerRadius
        button.layer.borderColor = borderColor.CGColor
    }
    
    func customizeProfileImage(){
        self.userProfileImageView.layer.cornerRadius = 8
        self.userProfileImageView.layer.borderWidth = 3
        self.userProfileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.userProfileImageView.clipsToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
}
