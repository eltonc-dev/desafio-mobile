//
//  FirstViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 18/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController ,
    UICollectionViewDelegate ,
    UICollectionViewDataSource ,
    FavoriteHandler{

    var favoriteProducts : [String] = [String]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var qtdProducts = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let favorites =  UserDefaults.standard.array(forKey: Constants.UserDefault.KEY_FAVORITE_PRODUCTS) as? [String] {
            self.favoriteProducts = favorites
        }
        
        
    }


    // MARK: - Collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.qtdProducts
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var view : UICollectionReusableView
        
        view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "products_header", for: indexPath)
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var wid :CGFloat
        if(self.traitCollection.horizontalSizeClass == .regular) {
            wid = (self.view.frame.size.width  / 4 )
        } else {
            wid = (self.view.frame.size.width  / 2)
        }
        
        
        return CGSize(width: wid , height: wid * 2 )
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = "product_cell"
        var cell : ProductCollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionViewCell
        
        cell.favoriteHandler = self
        cell.favoriteButton.tag = indexPath.row

        if( self.favoriteProducts.contains( String(indexPath.row) ) ) {
            cell.favoriteButton.isSelected = true
        } else {
            cell.favoriteButton.isSelected = false
        }
        
        return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if( scrollView.contentOffset.y  > scrollView.contentSize.height / 2 ) {
            
            
            if( !self.collectionView.isLoadingContent() ) {
                self.collectionView.startLoadingIndicator()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                    self.qtdProducts = self.qtdProducts + 10
                    self.collectionView.stopLoadingIndicator()
                })
            }
            
        }
    }
    
    // MARK: - FavoriteHandler Methods
    func saveAsFavorite(_ element: Any) {
        
        self.favoriteProducts.append( String((element as! UIButton).tag) )
        UserDefaults.standard.set(self.favoriteProducts, forKey: Constants.UserDefault.KEY_FAVORITE_PRODUCTS)
        
    }
    
    func removeFromFavorite(_ element: Any) {

        if( self.favoriteProducts.contains( String((element as! UIButton).tag) ) ) {
            let index = self.favoriteProducts.index(of: String((element as! UIButton).tag)  )
            if(index! < 0 ) {
                self.favoriteProducts.remove(at: index!)
                UserDefaults.standard.set(self.favoriteProducts, forKey: Constants.UserDefault.KEY_FAVORITE_PRODUCTS)
            }
        }
        
    }
    

}

