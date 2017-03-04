//
//  KinveyOperations.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
import Foundation
import UIKit
@objc protocol OperationProtocol {
    func onSuccess(Sender:AnyObject)
    func onError(message:String)
    func noActiveUser()
    func loginFailed()
    //f//unc fetch(ownerPost:OwnerPosts)
    //func sendValues(user:OwnerPosts)
}

class KinveyOperations {
    
    let store:KCSAppdataStore!
    //let ownerPost:KCSAppdataStore!
    let operaionDelegate:OperationProtocol!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    init(operationProtocol:OperationProtocol){
        self.operaionDelegate = operationProtocol
        
        store = KCSAppdataStore.storeWithOptions([
            KCSStoreKeyCollectionName : "Users",
            KCSStoreKeyCollectionTemplateClass : UserRegister.self
            ])
    
        
    }
    
    
    func saveData() {
        if let _ = KCSUser.activeUser() {
            
        }else{
            operaionDelegate.noActiveUser()
        }
    }
    
      func registerUser(user:UserRegister){
        
        let userRows  = [
            
            KCSUserAttributeEmail : user.emailID
        ]
        
        
        
        KCSUser.userWithUsername(
            user.emailID,
            password:user.password,
            fieldsAndValues: userRows, withCompletionBlock: { (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                    self.operaionDelegate.onSuccess(user)
                } else {
                    self.operaionDelegate.onError(errorOrNil.localizedDescription)
                }
            }
        )
        
        saveData()
        
        store.saveObject(
            user,
            withCompletionBlock: { (objectsOrNil: [AnyObject]!, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                   
                    print("Save failed, with error: %@", errorOrNil.localizedFailureReason)
                    self.operaionDelegate.onError("Username is already taken..Please retry your request with a different username")
                } else {
                    //save was successful
                    print("Successfully saved event (id='%@').", (objectsOrNil[0] as! NSObject).kinveyObjectId())
                    //self.operaionDelegate.onSuccess()
                }
            },
            withProgressBlock: nil
        )
        
    }
    
    func loginUser(userLogin:UserLogin){
        
        KCSUser.loginWithUsername(
            userLogin.email,
            password: userLogin.password, withCompletionBlock: {
                (user: KCSUser!, errorOrNil: NSError!, result: KCSUserActionResult) -> Void in
                if errorOrNil == nil {
                 let message = "login successful"
                    let alert = UIAlertView(
                        title: NSLocalizedString("Login successful", comment: "Sign account successful"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                    self.emailConfirmation(user.email)
            self.operaionDelegate.onSuccess(user)
                    
                } else {
                   
                    let message = errorOrNil.localizedDescription
                    let alert = UIAlertView(
                        title: NSLocalizedString("Login failed", comment: "Sign asasaaccount failed"),
                        message: message,
                        delegate: nil,
                        cancelButtonTitle: NSLocalizedString("OK", comment: "OK")
                    )
                    alert.show()
                    self.operaionDelegate.onError("login failed!")
               
                    
                }
            }
        )
        
    }

    
    func emailConfirmation(email:String){
        print(email)
        
        let activeUser = KCSUser.activeUser()
        KCSUser.sendEmailConfirmationForUser(
            activeUser.email,
            withCompletionBlock: { (emailSent: Bool, errorOrNil: NSError!) -> Void in
                if errorOrNil != nil {
                    self.operaionDelegate.onError("Please give valid emailID")
                } // not much to do on success, for most apps
            }
        )
    }
    
    
    }