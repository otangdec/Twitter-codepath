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
        
//        editProfileButton.layer.borderWidth = 1
//        editProfileButton.layer.cornerRadius = 5
//        editProfileButton.layer.borderColor = UIColor.grayColor().CGColor

        setBorder(editProfileButton,borderWidth: 1.0,cornerRadius: 5.0,borderColor: UIColor.grayColor())

        
        
//        print("FOLLOWERS: \(user?.followersCount)")
//        print("FOLLOWING: \(user?.followingCount)")
        
        numFollowersLabel.text = String(user!.followersCount!)
        
        numFollowingLabel.text = String(user!.followingCount!)
        

    
        
        
        // Do any additional setup after loading the view.
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

    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
