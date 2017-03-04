//
//  RegistrationViewController.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,OperationProtocol {
    
    
    var kinveyOperations:KinveyOperations!
    @IBOutlet weak var emailIDTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var confirmPasswordLBL: UITextField!
       @IBAction func registerBTN(sender: AnyObject) {
        var str:String = ""
        
        
        if emailIDTF.text!.isEmpty{
            str += "Please enter userName"+"\n"
        }
        let validEmailID:Bool = isValidEmail(emailIDTF.text!)
        print(validEmailID)
        if validEmailID == false {
            str += "Please enter valid emailID"+"\n"
        }
        if passwordTF.text!.isEmpty {
            str += "Please enter password"+"\n"
        }
     
        if confirmPasswordLBL.text!.isEmpty{
            str += "Please enter confirm password"+"\n"
        }
        var str1 = ""
        if passwordTF.text != confirmPasswordLBL.text {
            str1 = str+"confirm password is not matching with password"
        }
        else if passwordTF.text == confirmPasswordLBL.text{
            str1 = str
        }
        
        if str1 != "" {
            displayAlertControllerWithFailure("OOPS!", message: str1)
        }
        else {
            
            let user:UserRegister = UserRegister(emailID: emailIDTF.text!, password: passwordTF.text!, confirmPassword: confirmPasswordLBL.text!)
            
            kinveyOperations.registerUser(user)
            
        }
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        kinveyOperations = KinveyOperations(operationProtocol: self)
       self.view.backgroundColor = UIColor(patternImage: UIImage(named: "pic3.jpg")!)
       
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "Registration"
    }
    
    func onSuccess(Sender: AnyObject) {
        print("successfully saved the user register details")
        displayAlertControllerWithTitle("Success!", message: "Registration successful")
        

        
    }
    func onError(message: String) {
        print("*****\(message)")
        displayAlertControllerWithFailure("Error!", message: message)
    }
    func noActiveUser() {
        print("noActiveUser")
        
    }
    func loginFailed() {
        print("login failed")
    }
   
    
    func isValidEmail(username:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(username)
        
    }
        func isValidPassword(passwd:String) -> Bool {
           // println("validate calendar: \(testStr)")
          let emailRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).{4,8}$"
    
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluateWithObject(passwd)
    
      }

 
    
    
    func displayAlertControllerWithFailure(title:String, message:String) {
        let uiAlertController:UIAlertController = UIAlertController(title: title,
            message: message, preferredStyle: UIAlertControllerStyle.Alert)
        uiAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel,
            handler:{(action:UIAlertAction)->Void in }))
        self.presentViewController(uiAlertController, animated: true, completion: nil)
    }
    func displayAlertControllerWithTitle(title:String, message:String) {
        //let login: LoginViewController = LoginViewController()
        let uiAlertController:UIAlertController = UIAlertController(title: title,
            message: message, preferredStyle: UIAlertControllerStyle.Alert)
        uiAlertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel,
            handler:{action in self.performSegueWithIdentifier("returnToLogin",sender:self)}))
       self.presentViewController(uiAlertController, animated: true, completion: nil)
//        self.dismissViewControllerAnimated(true, completion: nil)
         self.performSegueWithIdentifier("returnToLogin", sender: nil)
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
