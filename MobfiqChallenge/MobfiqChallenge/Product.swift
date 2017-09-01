//
//  Product.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 30/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class Product: NSObject {

    
    struct SizeImages {
        static let THUMB : Int = 200
        static let SMALL : Int = 300
        static let MEDIUM : Int = 400
        static let BIG : Int = 900
    }
    
    var id : String!
    var name : String!
    var listPrice : Float!
    var price : Float!
    var bestInstallment : String!
    var imagensUrl : [String]!
    var mainImage : UIImage?

    
     init( info : NSDictionary? ) {
        if( info != nil ) {
            
            if ( info?.object(forKey: "Skus") != nil ) {
                
                let skus = info?.object(forKey: "Skus") as! NSArray
                //pego o primeiro apenas
                let skuItem  : NSDictionary = skus.object(at: 0) as! NSDictionary
                self.id = skuItem.object(forKey: "Id") as! String
                self.name = skuItem.object(forKey: "Name") as! String
                if ( skuItem.object(forKey: "Sellers") != nil ) {
                    let sellers = skuItem.object(forKey: "Sellers") as! NSArray
                    //pego o primeiro apenas
                    let sellerItem  : NSDictionary = sellers.object(at: 0) as! NSDictionary
                    self.listPrice = sellerItem.object(forKey: "ListPrice") as! Float
                    self.price = sellerItem.object(forKey: "Price") as! Float
                    if ( sellerItem.object(forKey: "BestInstallment") != nil ) {
                        if let bestInstallment = sellerItem.object(forKey: "BestInstallment") as? NSDictionary {
                            let strBestInstallment = "\(String(describing: bestInstallment.object(forKey: "Count")!))x de R$ \(String(describing: bestInstallment.object(forKey: "Value")!))"
                        
                        
                            self.bestInstallment = strBestInstallment
                        }
                    }
                    
                }
                
                if ( skuItem.object(forKey: "Images") != nil  ) {
                    if let imagens = skuItem.object(forKey: "Images") as? NSArray {
                        self.imagensUrl = []
                        for imagem in imagens {
                            let img : NSDictionary = imagem as! NSDictionary
                            self.imagensUrl.append(img.object(forKey: "ImageTag") as! String)
                        }
                    }
                }
                
            }
        }
    }
    
    func getImageUrlFromItemAtPosition(position:Int , size: Int ) -> String {
        if( self.imagensUrl != nil && self.imagensUrl.count > position ){
            return self.imagensUrl[position].replacingOccurrences(of: "#width#", with: String(size) ).replacingOccurrences(of: "#height#", with: String(size) )
        }
        return ""
    }
    
}
