//
//  sample.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/19/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit

class sample: UIViewController,  UITableViewDelegate, UITextFieldDelegate{
    //
    //  MyEvents.swift
    //  TravelDiaries
    //
    //  Created by Nadipudi,Arun on 4/19/16.
    //  Copyright © 2016 Nadipudi,Arun. All rights reserved.
    //
    
    
          var store:KCSAppdataStore!
        
        var results:[PostRide]!
        
        var results1:[PostRide]!
    
        
           
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
       
            
            
            store = KCSAppdataStore.storeWithOptions([ // a store represents a local connection to the cloud data base
                
                KCSStoreKeyCollectionName : "PostDetails",
                
                KCSStoreKeyCollectionTemplateClass : PostRide.self
                
                ])
            
            
            
            let query = KCSQuery(onField: "email", withExactMatchForValue: KCSUser.activeUser().email)
            
            
            
            
            
            store.queryWithQuery(query, withCompletionBlock: { (resultData:[AnyObject]!, errorOrNil: NSError!) -> Void in
                
                if errorOrNil == nil {
                    
                    //was successful!
                    
                    self.displayAlertControllerWithTitle("Post retrived", message: "posted")
                    
              
                    
                    self.results=resultData as! [PostRide]
                    
                   self.sampleTV.reloadData()
                    
                    
                }}, withProgressBlock: nil)
            
            
            
            
        }
        
  
        
    @IBOutlet var sampleTV: UITableView!
        
        
        
        
        
        override func didReceiveMemoryWarning() {
            
            super.didReceiveMemoryWarning()
            
            // Dispose of any resources that can be recreated.
            
        }
        
        
  
        
        
        //
        //    func reloadData(hmm:AnyObject?){
        //
        //        self.resultsTV.reloadData()
        //
        //
        //
        //    }
        //
        //
        
        
        
        func displayAlertControllerWithTitle(title:String, message:String) {
            
            let uiAlertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            uiAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler:{(action:UIAlertAction)->Void in  }))
            
            self.presentViewController(uiAlertController, animated: true, completion: nil)
            
            
            
        }
        

        
        
        
        
        
        
        
         func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            
            return 1
            
        }
        
        
        
         func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return results == nil ? 0 : results.count
            
        }
        
        
        
        
        
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cell1:UITableViewCell
            if (indexPath.row % 2 == 0) {
                cell1 = tableView.dequeueReusableCellWithIdentifier("type1", forIndexPath: indexPath)
            }
            else {
                cell1 = tableView.dequeueReusableCellWithIdentifier("type2", forIndexPath: indexPath)
              
            }

            
           
            
            
            
            //        cell.viewWithTag(100).text = results[indexPath.row].from
            
            //        cell.toLbl!.text = results[indexPath.row].to
            
            let title1:UILabel = cell1.viewWithTag(1) as! UILabel
            
            
            
            let date:UILabel = cell1.viewWithTag(2) as! UILabel
            
            let location:UILabel = cell1.viewWithTag(3) as! UILabel
let image1 = cell1.viewWithTag(4) as! UIImageView
            
            
            
            
          
            
            title1.text = results[indexPath.row].title
            print(title1.text)
            date.text = results[indexPath.row].date
            let getLocation=results[indexPath.row].location
            location.text = getLocation
          print(results[indexPath.row].image)
   //image1.image = UIImage(named: results[indexPath.row].image as String)
            
        
            KCSFileStore.downloadFile(
           getLocation,
                options: nil,
                completionBlock: { (downloadedResources: [AnyObject]!, error: NSError!) -> Void in
                    if error == nil {
                        let file = downloadedResources[0] as! KCSFile
                        let fileURL = file.localURL
                        
                        let image = UIImage(contentsOfFile: fileURL.path!) //note this blocks for awhile
                        /****** assign it to imageview to display the image ********/
                        image1.image = image
                        //               self.productImages.append(candidateIV.image!)
                    } else {
                        NSLog("Got an error: %@", error)
                    }
                },
                progressBlock: nil
            )
            
 
            
            return cell1
            
        }
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let eventsDetails:PostRide = results[indexPath.row]
        print(eventsDetails.description)
        let ownerDetails:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        ownerDetails.ownerDetails = eventsDetails
        
        

 self.performSegueWithIdentifier("showevents", sender: nil)
        
    }
    
     func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        print("tableview acc")
        tableView.targetForAction("navigate:", withSender: indexPath.row)
    }

    
    
    }
    
    
    
    
    
    
    
    
    
    

