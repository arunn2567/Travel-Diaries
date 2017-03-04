//
//  HomeViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/12/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pic09.jpg")!)
      
    }

    @IBAction func LogoutButtonTapped(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("back1", sender: self)
    }

}