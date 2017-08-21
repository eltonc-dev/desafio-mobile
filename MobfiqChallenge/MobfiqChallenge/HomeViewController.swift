//
//  FirstViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 18/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController ,
    UICollectionViewDelegate ,
    UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var qtdProducts = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        var cell : UICollectionViewCell!
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        
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

}

