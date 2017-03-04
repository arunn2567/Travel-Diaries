//
//  PostRide.swift
//  TravelDiaries
//
//  Created by Nadipudi,Arun on 4/11/16.
//  Copyright © 2016 Nadipudi,Arun. All rights reserved.
//

import Foundation
class PostRide :NSObject {
    
    var entityId: String? // Kinvey entity _id -- had to add this
    var email:String!
    var title:String!
    var date:String!
    var location: String!
    var notes: String!
    var image:String!
    
    
    
    override init(){
        super.init()
    }
    
    init(email:String, title:String, date:String, location: String , notes : String, image : String) {
        self.email = email
        self.title = title
        self.date = date
        self.location = location
        self.notes = notes
        self.image = image
    }
    
    override func hostToKinveyPropertyMapping() -> [NSObject : AnyObject]! {
        return [
            "entityId" : KCSEntityKeyId, //the required _id field
            "email" : "email",
            "title" : "title",
            "date" : "date",
            "location" : "location",
            "notes" : "notes",
            "image" : "image"
        ]
    }
    
    
    
}