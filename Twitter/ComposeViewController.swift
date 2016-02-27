//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Oranuch on 2/26/16.
//  Copyright © 2016 Sarn. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var numCharLeft: UILabel!
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var userImageView: UIImageView!
    var numLeft: Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tweetButton.layer.cornerRadius = 5
        tweetTextView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneCompose(sender: AnyObject) {
        
        // to dismiss view that's presented using modal
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        numLeft =  140 - tweetTextView.text!.utf16.count
        numCharLeft.text = "\(numLeft!)"
        
        // If no more character allows, textview will not accept anymore character
        // users can use backspace to delete the character
        if numLeft == 0{
            tweetTextView.deleteBackward()
        }

        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        tweetTextView.text = nil
        tweetTextView.textColor = UIColor.blackColor()
    }

}
