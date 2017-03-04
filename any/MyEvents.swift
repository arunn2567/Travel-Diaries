//
//  MyEvents.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/19/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit

class MyEvents: UIViewController,UITableViewDelegate,UITextFieldDelegate {
    var store:KCSAppdataStore!
    
    var results:[PostRide]!
    
    var results1:[PostRide]!
       @IBOutlet weak var title1: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var image: UIImage!
    
    


    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        store = KCSAppdataStore.storeWithOptions([ // a store represents a local connection to the cloud data base
            
            KCSStoreKeyCollectionName : "PostDetails",
            
            KCSStoreKeyCollectionTemplateClass : PostRide.self
            
            ])
        
        
        
        let query = KCSQuery()
        
        
        
        
        
        store.queryWithQuery(query, withCompletionBlock: { (resultData:[AnyObject]!, errorOrNil: NSError!) -> Void in
            
            if errorOrNil == nil {
                
                //was successful!
                
                self.displayAlertControllerWithTitle("Post retrived", message: "posted")
                
                //                for results in resultData{
                
                //                    print(results.
                
                //                }
                
                //                for obj in resultData
                
                //                {
                
                //                    print(obj)
                
                //                }
                
                // print(resultData[0])
                
                self.results=resultData as! [PostRide]
                
//                for var i=0; i<resultData.count; i++
//                    
//                {
//                    
//                    if self.fromtxt.text == self.results[i].from && self.totxt.text == self.results[i].to
//                        
//                    {
//                        
//                        self.results1=self.results
//                        
//                        
//                        
//                    }
//                        
//                    else
//                        
//                    {
//                        
//                        self.results1 = nil
//                        
//                    }
//                    
//                }
//                
//                if(!(self.results1.count == 0))
//                    
//                {
//                    
//                    self.resultsTV.hidden = false
//                    
//                    self.resultsTV.reloadData()
//                    
//                }
//                    
//                else
//                    
//                {
//                    
//                    self.myUtterance = AVSpeechUtterance(string: "You have no rides on that day!")
//                    
//                    self.myUtterance.rate = 0.3
//                    
//                    self.synth.speakUtterance(self.myUtterance)
//                    
//                    
//                    
//                }
//                
//                
//                
//                
//                
//                
//                
//            }
//                
//            else
//                
//            {
//                
//                //there was an error with the update save
//                
//                let message = errorOrNil.localizedDescription
//                
//                self.displayAlertControllerWithTitle("There are no rides.!", message: message)
//                
//            }
//            
            
            
            
            }}, withProgressBlock: nil)

        
        }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
    
    
    @IBAction func FindClk(sender: AnyObject) {
        
        
        
        
        
        
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
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        if(segue.identifier=="resultsegue")
//            
//        {
//            
//            if let destVC = segue.destinationViewController as? DetailsViewController
//                
//                
//                
//            {
//                
//                if let displayIndex = resultsTV.indexPathForSelectedRow?.row {
//                    
//                    
//                    
//                    destVC.results = self.results
//                    
//                    destVC.from = results1[displayIndex].from
//                    
//                    destVC.to = results1[displayIndex].to
//                    
//                    destVC.date = results1[displayIndex].datetime
//                    
//                    destVC.availability = results1[displayIndex].availability
//                    
//                    destVC.contact = results1[displayIndex].contact
//                    
//                    destVC.ind = displayIndex
//                    
//                    
//                    
//                    
//                    
//                }
//                
//            }
//            
//            
//            
//            
//            
//        }
//        
//    }
    
    //
    
    
    
    
    
    
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return results == nil ? 0 : results.count
        
    }
    
    
    

    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        
        
        //        cell.viewWithTag(100).text = results[indexPath.row].from
        
        //        cell.toLbl!.text = results[indexPath.row].to
        
        let title1:UILabel = cell.viewWithTag(1) as! UILabel
        
        
        
        let date:UILabel = cell.viewWithTag(2) as! UILabel
        
        let location:UILabel = cell.viewWithTag(3) as! UILabel
//        
//        let image:UIImage = cell.viewWithTag(4) as! UIImage
        
     
        
        
        
        
        
        title1.text = results1[indexPath.row].title
        
        date.text = results1[indexPath.row].date
        
        location.text = results1[indexPath.row].location
        
//     image.images = results1[indexPath.row].image
        
        
        
        
        
        
        
        
        
        
        
        return cell
        
    }
    
    
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    //        // Get the new view controller using segue.destinationViewController.
    
    //        // Pass the selected object to the new view controller.
    
    //        if segue.identifier == "detailsegue"  {
    
    //            if let destinationViewController = segue.destinationViewController as? DetailsViewController {
    
    ////                if let rowIndex = tableView.indexPathForSelectedRow?.row{
    
    ////                    destinationViewController.department = university.departments[rowIndex]
    
    ////                }
    
    //                if 
    
    //            }
    
    //            
    
    //        }
    
}

    








/*store.group(

KCSMetadataFieldCreator,

reduce: KCSReduceFunction.COUNT(),

condition: KCSQuery(

onField: "datetime",

usingConditional: KCSQueryConditional.withExactMatchForValue,

forValue: NSDate()

),

completionBlock: { (valuesOrNil: KCSGroup!, errorOrNil: NSError!) -> Void in

//get the number of events for id "Bob" - (note, by default user ids will be a random string not the names)

let numberOfBobEvents = valuesOrNil.reducedValueForFields([ KCSMetadataFieldCreator : "Bob" ]) as! NSObject

NSLog("Bob has %@ future events", numberOfBobEvents)

},

progressBlock: nil

)

}*/




