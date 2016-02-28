//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Oranuch on 2/26/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit

//protocol UserProfileViewControllerDelegate {
//    func getUserInfo()
//}

class UserProfileViewController: UIViewController {
    
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
    
    
    var tweet: Tweet!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
            
            numFollowersLabel.text = String(user!.followersCount!)
            
            numFollowingLabel.text = String(user!.followingCount!)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func doneCompose(sender: AnyObject) {
        
        // to dismiss view that's presented using modal
        self.dismissViewControllerAnimated(true, completion: nil)
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
