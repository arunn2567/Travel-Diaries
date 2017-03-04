//
//  PhotosViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/20/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit
import Photos

let reuseIdentifier = "PhotoCell"
let albumName = "App Folder1"



class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource   {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var results:[PostRide]!
    var ownerPostsDetailsObject:PostRide!
    var store:KCSAppdataStore!
    var images = []
    
    override func viewDidLoad() {
    
        // Do any additional setup after loading the view, typically from a nib.
        
        
          super.viewDidLoad()
        store = KCSAppdataStore.storeWithOptions([ // a store represents a local connection to the cloud data base
            
            KCSStoreKeyCollectionName : "PostDetails",
            
            KCSStoreKeyCollectionTemplateClass : PostRide.self
            
            ])

        let eventsDetails:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //let userDetails:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.ownerPostsDetailsObject = eventsDetails.ownerDetails
        //let user = userDetails.user
        let getlocation:String = ownerPostsDetailsObject.location
        let query = KCSQuery(onField: "location", withExactMatchForValue: getlocation)
        store.queryWithQuery(query, withCompletionBlock: { (resultData:[AnyObject]!, errorOrNil: NSError!) -> Void in
            
            if errorOrNil == nil {
              
                    self.results=resultData as! [PostRide]
                  print("arun wegraerbega:\(self.results[0].location)")
                KCSFileStore.downloadFile(
                    getlocation,
                    options: nil,
                    completionBlock: { (downloadedResources: [AnyObject]!, error: NSError!) -> Void in
                        if error == nil {
                            let file = downloadedResources[0] as! KCSFile
                            let fileURL = file.localURL
                            
                            let image = UIImage(contentsOfFile: fileURL.path!)
                            //note this blocks for awhile
                            /****** assign it to imageview to display the image ********/
                          
                            //               self.productImages.append(candidateIV.image!)
                        } else {
                            NSLog("Got an error: %@", error)
                        }
                    },
                    progressBlock: nil
               )

                
            }
        }, withProgressBlock: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return results.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        
        let myCell:MyCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath) as! MyCollectionViewCell
        
        myCell.myImageView.image = nil
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let imageHolder = self.results[indexPath.row].image
      
            let imageUrl = NSURL(string: imageHolder)
            let imageData = NSData(contentsOfURL: imageUrl!)
            print("arun :\(imageUrl)")
            dispatch_async(dispatch_get_main_queue(),{
                if(imageData != nil)
                {
                    myCell.myImageView.image = UIImage(data: imageData!)
                }
            });
            
        });
        
        return myCell
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        print("User tapped on image # \(indexPath.row)")
        
        
        let myImageViewPage:MyImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MyImageViewController") as! MyImageViewController
        
        
        let imageHolder = self.images[indexPath.row] as! [String:AnyObject]
        let imagePreviewString = imageHolder["preview"] as! String
        
        myImageViewPage.selectedImage = imagePreviewString
        
        self.navigationController?.pushViewController(myImageViewPage, animated: true)
        
    }

}