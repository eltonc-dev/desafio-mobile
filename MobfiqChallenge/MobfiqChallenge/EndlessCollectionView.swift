//
//  EndlessCollectionView.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 20/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    
    func isLoadingContent() -> Bool {
        if( self.viewWithTag(999999) != nil ) {
            return true
        }
        return false
    }
    
    
    func startLoadingIndicator () {
        if( self.viewWithTag(999999) == nil ) {
            let indicator : UIActivityIndicatorView! = UIActivityIndicatorView()
            indicator.color = UIColor.red
            indicator.frame = CGRect(x: (self.frame.size.width / 2 ) - 15 , y: self.contentSize.height, width: 30, height: 30)
            indicator.startAnimating()
            indicator.hidesWhenStopped = true
            indicator.tag = 999999
            self.addSubview(indicator)
            
            self.contentSize.height = self.contentSize.height + 40
            self.contentInset.bottom = self.contentInset.bottom + 40
        }
        
    }
    
    func stopLoadingIndicator() {
        
        
        
        let indicator : UIActivityIndicatorView = self.viewWithTag(999999) as! UIActivityIndicatorView
        indicator.stopAnimating()
        self.reloadData()
        self.contentSize.height = self.contentSize.height - 40
        self.contentInset.bottom = self.contentInset.bottom - 40
        
        indicator.removeFromSuperview()
        
    }
    
    
}
