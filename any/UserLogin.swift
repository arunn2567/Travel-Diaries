//
//  UserLogin.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import Foundation
class UserLogin:NSObject{
    var email:String
    var password:String
    
    init(email:String, password:String) {
        self.email = email
       self.password = password
    }

}