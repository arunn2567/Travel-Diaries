//
//  LoginPageViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {

    @IBOutlet weak var UserEmailTF: UITextField!
    @IBOutlet weak var UserPasswordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func LoginButtonTapped(sender: AnyObject) {
        let userEmail = UserEmailTF.text;
        let userPassword = UserPasswordTF.text;
        
        let userEmailStored = "as"
        let userPasswordStored = "as"
        
        if(userEmailStored == userEmail)
        {
            if(userPasswordStored == userPassword)
            {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize();
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
