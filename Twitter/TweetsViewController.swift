//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Oranuch on 2/12/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit
import MBProgressHUD

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ComposeViewControllerDelegate, TweetCellDelegate{



    @IBOutlet weak var composeButton: UIBarButtonItem!

    @IBOutlet weak var tableView: UITableView!

    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl!
    var userScreenName: String?
    var userForUserProfile: User?
    var tweetForUserProfile: Tweet?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        initializeRefreshControl()
        networkRequest()
        initializeNavigationBar()

    }
    
    
    func initializeNavigationBar(){
        self.navigationItem.title = "Tweet"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
//
//        delay(5, closure: {
//            self.refresh(self)
//        })
//        self.tableView.reloadData()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func delay(delay: Double, closure: () -> () ) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure
        )
    }
    
    // Delegate Methods
    func myModalDidFinish(controller: ComposeViewController) {
        print("Closing Modal Compose view")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createdTweet(composeViewController: ComposeViewController) {
//        self.getTimelineTweets()
        print("In CreatedTweet")
        self.refreshControl.beginRefreshing()
        let completion = {(tweets: [Tweet]?, error: NSError?) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
        TwitterClient.sharedInstance.homeTimeline(completion)
 
    }
    
    func didReply(tweetCell: TweetCell) {
        
        print("Did Reply")
        // get the selected user screen name
        userScreenName = tweetCell.user.screenName
        performSegueWithIdentifier("replyFromHomeSegue", sender: self)
    }
    
    
    func didTapProfileImage(tweetCell: TweetCell) {
        userForUserProfile = tweetCell.user
        tweetForUserProfile = tweetCell.tweet
        performSegueWithIdentifier("userProfileSegue", sender: self)
    }
    
   
    func networkRequest(){
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        TwitterClient.sharedInstance.hometTimelineWithParams(nil,
            completion: { (tweets, error) -> () in
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.tweets = tweets
                self.tableView.reloadData()
        })
    }
    
    func initializeRefreshControl(){
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
//    func refresh(sender:AnyObject){
//        networkRequest()
//        self.refreshControl.endRefreshing()
//    }

    func onRefresh(){
        networkRequest()
        self.refreshControl.endRefreshing()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.delegate = self
        cell.tweet = tweets![indexPath.row]
        cell.user = tweets![indexPath.row].user
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detailSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let user = tweets![indexPath!.row].user!
            let detailViewController = segue.destinationViewController  as! DetailViewController
            detailViewController.tweet = tweet
            detailViewController.user = user
        }
        
        if segue.identifier == "composeSegue" {
            let composeViewController = segue.destinationViewController as! ComposeViewController
            composeViewController.delegate = self
            
        }
        if segue.identifier == "replyFromHomeSegue" {
            let composeViewController = segue.destinationViewController as! ComposeViewController
            print("User Screen Name: \(userScreenName)")
            composeViewController.replyToUserScreenName = userScreenName
        }
        if segue.identifier == "userProfileSegue" {
            let userProfileViewController = segue.destinationViewController as! UserProfileViewController
            userProfileViewController.user = userForUserProfile
            userProfileViewController.tweet = tweetForUserProfile
        }
    }
}
