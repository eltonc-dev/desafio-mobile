//
//  Category.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 21/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//


import Foundation

class Category: NSObject {

    var id : Int!
    var name : String!
    var apiQuery : String!
    var subCategories : [Category]!
    
    init( info : NSDictionary? ) {
        if( info != nil ){
            if ( info?.object(forKey: "id") != nil ) {
                self.id = info?.object(forKey: "id") as! Int
            }
            
            if( info?.object(forKey: "Name") != nil ) {
                self.name = info?.object(forKey: "Name") as! String
            }
            
            if ( info?.object(forKey: "SubCategories") != nil ) {
                
                if let subs = info?.object(forKey: "SubCategories") as? [NSDictionary] {
                    self.subCategories = [Category]()
                    for s in subs {
                        let subCategory = Category(info: s)
                        self.subCategories.append(subCategory)
                    }
                }
            }
            
            if( info?.object(forKey: "Redirect") != nil ){
                let redirect = info?.object(forKey: "Redirect") as! NSDictionary
                if( redirect.object(forKey: "SearchCriteria") != nil ) {
                    let criteria = redirect.object(forKey: "SearchCriteria") as! NSDictionary
                    if( criteria.object(forKey: "ApiQuery") != nil ) {
                        self.apiQuery = criteria.object(forKey: "ApiQuery") as! String
                    }
                }
            }
            
        }
    }
}
