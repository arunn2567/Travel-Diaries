//
//  Register.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import Foundation




class UserRegister :NSObject {
    
    
    var emailID:String
    var password:String
    var confirmPassword:String
    
    var entityId: String? // Kinvey entity _id -- had to add this


    init(emailID:String, password:String, confirmPassword:String){
     
      
        self.emailID = emailID
        self.password = password
        self.confirmPassword = confirmPassword
        
        
    }
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
       "emailID" : "emailID",
            "password" : "password",
       
        ]
    }
    

}