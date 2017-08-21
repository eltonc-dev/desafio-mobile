//
//  ProductsViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 19/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout {

    var category :Category!
    var searchTerm : String!
    
    var qtdProducts = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ( category != nil ) {
            //busca por categoria
        }
        
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationItem.hidesBackButton = false
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    

    
    // MARK: - Collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return qtdProducts
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
        
        if( indexPath.row == self.qtdProducts - 4 ) {
            qtdProducts = qtdProducts + 10
            collectionView.startLoadingIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: {
                collectionView.stopLoadingIndicator()
            })
        }
        
        return CGSize(width: wid , height: wid * 2 )
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = "product_cell"
        var cell : UICollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        
        return cell
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("Scroll")
    }
 

}
