//
//  ViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,OperationProtocol {
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var emailIDTF: UITextField!
    var store:KCSAppdataStore!
    var kinveyOperations:KinveyOperations!
    var email:String!
    
 
    
    @IBAction func loginBTN(sender: AnyObject) {
        let userLogin:UserLogin = UserLogin(email: emailIDTF.text!, password: passwordTF.text!)
        kinveyOperations.loginUser(userLogin)
        
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let filePath = NSBundle.mainBundle().pathForResource("railway", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        let webViewBG = UIWebView(frame: self.view.frame)
        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webViewBG.userInteractionEnabled = false;
        self.view.addSubview(webViewBG)
        let filter = UIView()
        filter.frame = self.view.bounds
        filter.backgroundColor = UIColor.blackColor()
        filter.alpha = 0.05
        filter.sizeToFit()
        self.view.addSubview(filter)
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        kinveyOperations = KinveyOperations(operationProtocol: self)
        self.navigationItem.setHidesBackButton(true, animated: false)
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onSuccess(x:AnyObject) {
        email = emailIDTF.text!
        let app:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let backItem = UIBarButtonItem()
        backItem.title = "logout"
        navigationItem.backBarButtonItem = backItem
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        performSegueWithIdentifier("success", sender: self)
        
        }
    
   
    func onError(message: String) {
        print(message)
    }
    
    func noActiveUser() {
        print("noActiveUser")
    }
    
    func loginFailed() {
        print("login failed")
    }
    
    
    
}
