//
//  MyImageViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.

import UIKit

class MyImageViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    var selectedImage:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
        
        let imageUrl = NSURL(string: self.selectedImage)
        let imageData = NSData(contentsOfURL: imageUrl!)
        
          dispatch_async(dispatch_get_main_queue(),{
              if(imageData != nil)
              {
               self.myImageView.image = UIImage(data: imageData!)
               }
          });
            
        });
        
    }
    



}
