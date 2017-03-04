//
//  KCSUserExtension.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import Foundation



let UserRole = "Role"

extension KCSUser{
    
    var role:String {
        return self.getValueForAttribute(UserRole) as! String!
    }
    
    
}