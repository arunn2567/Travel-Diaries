//
//  AddMemViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/13/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit


class AddMemViewController: UIViewController,CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var locationvar:String=""
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var title1: UITextField!
    @IBOutlet weak var navigation: UINavigationBar!
    @IBOutlet weak var Notes: UITextView!
    @IBOutlet weak var getlocation: UITextField!
    var store:KCSAppdataStore!
    
    
    @IBOutlet weak var AddButton: ZFRippleButton!
    @IBAction func addImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.editing = false;
        imagePicker.delegate = self;
        //        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        //        self.presentViewController(imagePicker, animated: true, completion: nil)
        //
        func displayAlertControllerWithFailure1(title:String, message:String) {
            let uiAlertController:UIAlertController = UIAlertController(title: title,
                message: message, preferredStyle: UIAlertControllerStyle.Alert)
            uiAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel,
                handler:{(action:UIAlertAction)->Void in }))
            self.presentViewController(uiAlertController, animated: true, completion: nil)
     
            
        }
        
        let actionsheet = UIAlertController(title: "Photo Gallery", message: "select a photo", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let libButton = UIAlertAction(title: "Select from photo library", style: UIAlertActionStyle.Default) { (libSelected) -> Void in
            print("Library selected")
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
        actionsheet.addAction(libButton)
        let cameraButton = UIAlertAction(title: "Take Picture", style: UIAlertActionStyle.Default) { (camSelected) -> Void in
            print("Camera selected")
            if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
            {
                imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            else
            {
                displayAlertControllerWithFailure1("OOPS!", message: "You does'nt have a camera")
                
            }
            
            
        }
        actionsheet.addAction(cameraButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (cancelSelected) -> Void in
            print("Cancel selected")
        }
        actionsheet.addAction(cancelButton)
        self.presentViewController(actionsheet, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.selectedImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        self.AddButton.hidden = true

    }
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var location: UIButton!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        
    }
    override func viewDidLoad() {
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pic11.jpg")!)
        super.viewDidLoad()
        selectedImage.layer.cornerRadius = 6.0
        selectedImage.clipsToBounds = true
              Notes.layer.borderWidth = 0.5
        Notes.layer.borderColor = UIColor.blackColor().CGColor
        Notes.layer.cornerRadius = 6.0
        
        store = KCSAppdataStore.storeWithOptions([ // a store represents a local connection to the cloud data base
            KCSStoreKeyCollectionName : "PostDetails",
            KCSStoreKeyCollectionTemplateClass : PostRide.self
                ])//        vanavigationController?.navigationBar.frame.origin.y = -10
        
    }
    
    @IBAction func findMyLocation(sender: AnyObject) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] as! CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            getlocation.text=locality! + ", " + country!
        }
        
    }

var imageUrl:String = ""
    @IBAction func postClicked(sender: AnyObject) {
        if Notes.text == "" || getlocation.text == "" || title1.text == "" || dateTextField.text == ""  {
            self.displayAlertControllerWithTitle("Alert", message: "Enter all the fields")
        }
        else {
            if let _ = selectedImage.image
            {
                uploadImage(selectedImage.image!)
            }
            
            var imageUrl:String = ""
            if let _ = selectedImage.image?.description{
                imageUrl = (selectedImage.image?.description)!
            }
//      print("arun",
//        (imageUrl))
       
            let post:PostRide = PostRide(email: KCSUser.activeUser().email , title:title1.text!, date:dateTextField.text!, location: getlocation.text! , notes : Notes.text!, image : imageUrl)
            
            store.saveObject(
                post,
                withCompletionBlock: {(objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                    if errorOrNil != nil {
                        //was successful!
                        self.displayAlertControllerWithTitle("Alert", message: "Event cannot be created. please check all the fields")
                        print("Save failed, with error: %@", errorOrNil.localizedFailureReason)
                    } else {
                        //there was an error with the update save
                          self.performSegueWithIdentifier("saving", sender: nil)
                        self.displayAlertControllerWithTitle("Alert", message:"Event in the diary created successfully " )
                        print("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                      
                    }
                } ,
                withProgressBlock: nil
           )
            
        }
        
    }
    
    func uploadImage(image:UIImage) {
        //self.productAds.productImage = ""
        
        /******** here product is stored using decription which is entered in an input text box(descriptionTV) ************/
        var address:String = "Not Specified"
        if let _ = getlocation.text
        {
            address = getlocation.text!
        }
        
        let data = UIImageJPEGRepresentation(image, 0.5) //convert to a 90% quality jpeg
        KCSFileStore.uploadData(
            data,
            options: [KCSFileFileName : "\(address)",
                KCSFileMimeType : "image/jpeg",
                KCSFileId : "\(address)"],
            completionBlock: { (uploadInfo: KCSFile!, error: NSError!) -> Void in
                //NSLog("Upload finished. File id='%@', error='%@'.", uploadInfo.fileId, error)
              
            },
            progressBlock: nil
        )
    }

    func displayAlertControllerWithTitle(title:String, message:String) {
        //let login: LoginViewController = LoginViewController()
        let uiAlertController:UIAlertController = UIAlertController(title: title,
            message: message, preferredStyle: UIAlertControllerStyle.Alert)
        uiAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel,
            handler:{action in self.performSegueWithIdentifier("saving",sender:self)}))
     
     
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    @IBOutlet weak var dateTextField: UITextField!
    
    
    
    @IBAction func dp(sender: UITextField) {
        var datePickerView  : UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: Selector("handleDatePicker:"), forControlEvents: UIControlEvents.ValueChanged)
        
    }
    func handleDatePicker(sender: UIDatePicker) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateTextField.text = dateFormatter.stringFromDate(sender.date)
    }
}