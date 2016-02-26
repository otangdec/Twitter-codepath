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
        
        descriptionLabel.text = user!.description

    
        
        
        // Do any additional setup after loading the view.
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
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
