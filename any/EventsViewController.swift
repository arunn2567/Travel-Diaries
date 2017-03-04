//
//  EventsViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/20/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var title2: UILabel!

    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var location: UILabel!
    var ownerPostsDetailsObject:PostRide!
    @IBAction func LogoutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("detail", sender: self)
    }

    override func viewDidLoad() {
      
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pic11.jpg")!)
        let eventsDetails:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let userDetails:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.ownerPostsDetailsObject = eventsDetails.ownerDetails
        //let user = userDetails.user

        
        title2.text = ownerPostsDetailsObject.title
        let getlocation:String = ownerPostsDetailsObject.location
        location.text = getlocation
        notes.text = ownerPostsDetailsObject.notes
         navigation.topItem!.title = ownerPostsDetailsObject.date
        notes.layer.borderWidth = 1
        notes.layer.borderColor = UIColor.whiteColor().CGColor
        KCSFileStore.downloadFile(
            getlocation,
            options: nil,
            completionBlock: { (downloadedResources: [AnyObject]!, error: NSError!) -> Void in
                if error == nil {
                    let file = downloadedResources[0] as! KCSFile
                    let fileURL = file.localURL
                    
                    let image = UIImage(contentsOfFile: fileURL.path!) //note this blocks for awhile
                    /****** assign it to imageview to display the image ********/
                    self.image1.image = image
                    //               self.productImages.append(candidateIV.image!)
                } else {
                    NSLog("Got an error: %@", error)
                }
            },
            progressBlock: nil
        )

     
        
    }
}