//
//  ProductCollectionViewCell.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 20/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    var favoriteHandler : FavoriteHandler?
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var promotionView: UIView!
    @IBOutlet weak var promotionPercentage: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productOldPrice: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productBestPaymentType: UILabel!
    
    
    @IBAction func toggleFavorite(_ sender: UIButton) {
        
        DispatchQueue.main.async(execute: {
            sender.isSelected = !sender.isSelected
            
            if( self.favoriteHandler != nil) {
                if(sender.isSelected) {
                    self.favoriteHandler?.saveAsFavorite(sender)
                } else {
                    self.favoriteHandler?.removeFromFavorite(sender)
                }
            }
        });
        
    }
    
    // MARK - Delegate
    
    
}
