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
    FavoriteHandler,
    RequestHandler {

    var favoriteProducts : [String] = [String]()
    
    var offset: Int = 0
    var itensPerPage = 10
    var sessionTask : URLSessionDataTask?
    var productList : [Product] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let favorites =  UserDefaults.standard.array(forKey: Constants.UserDefault.KEY_FAVORITE_PRODUCTS) as? [String] {
            self.favoriteProducts = favorites
        }
        
        self.loadProducts()
        self.collectionView.startLoadingIndicator()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    // MARK: - HELPER FUNCTIONS
    func nextPage() {
        self.offset = self.offset + self.itensPerPage
        //request
        self.loadProducts()
    }
    
    func loadProducts() {
        let params :  NSMutableDictionary = NSMutableDictionary()
        params.setValue(self.offset, forKey: Constants.UrlParams.OFFSET)
        params.setValue(self.itensPerPage, forKey: Constants.UrlParams.SIZE)
        self.sessionTask = RequestHelper.postRequest(on: Constants.Url.PRODUCTS, with: params, and: self)
    }

    // MARK: - Collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productList.count
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
        let product = self.productList[indexPath.row]
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ProductCollectionViewCell
        cell.loader.hidesWhenStopped = true
        
        cell.favoriteHandler = self
        cell.favoriteButton.tag = Int( product.id )!

        if( self.favoriteProducts.contains( product.id ) ) {
            cell.favoriteButton.isSelected = true
        } else {
            cell.favoriteButton.isSelected = false
        }
        
        if( product.mainImage == nil && cell.imageRequest == nil ) {
            cell.loader.startAnimating()
            _ = RequestHelper.loadImageFrom(imageUrl: product.getImageUrlFromItemAtPosition(position: 0 , size: Product.SizeImages.THUMB ), with: self , and: indexPath.row )
            
        } else {
            
            if( product.mainImage != nil ) {
                    cell.loader.stopAnimating()
                    cell.productImageView.image = product.mainImage
            }
            
            if( cell.imageRequest == nil ) {
                cell.loader.stopAnimating()
            }
        }
        
        
        
        
        cell.productName.text = product.name
        
        cell.productOldPrice.text = "R$ \(String(format: "%.2f", arguments: [product.listPrice!]))"
        cell.productPrice.text = "R$ \(String(format: "%.2f", arguments: [product.price!]))"
        
        cell.productBestPaymentType.text = product.bestInstallment
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let product = self.productList[indexPath.row]
        
        
        let productsDetails : ProductDetailViewController =  UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "productsDetails") as! ProductDetailViewController
        productsDetails.product = product
        self.navigationController?.pushViewController(productsDetails, animated: true)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if( scrollView.contentOffset.y  > scrollView.contentSize.height / 2 ) {
            
            
            if( !self.collectionView.isLoadingContent() ) {
                self.collectionView.startLoadingIndicator()
                self.nextPage()
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
    
    // MARK: - Request Handler Methods
    
    func requestSuccess(with data: Any, forRequest request: URLRequest) {
        
        DispatchQueue.main.async(execute: {
            if( self.collectionView.isLoadingContent() ) {
                self.collectionView.stopLoadingIndicator()
            }
        })
        
        let info : NSDictionary = data as! NSDictionary
        
        if( info.object(forKey: Constants.UrlParams.PRODUCTS) != nil ) {
            let products = info.object(forKey: Constants.UrlParams.PRODUCTS) as! NSArray
            for p in products {
                let productDic : NSDictionary  = p as! NSDictionary
                let product = Product(info: productDic)
                self.productList.append(product)
                
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData()
                })
            }
        }
        
    }
    func requestSuccess(with data: Any, withIdentifier ident: String) {
        //usado para imagens
        let product : Product = self.productList[Int(ident)!] 
        product.mainImage = data as? UIImage
        DispatchQueue.main.async(execute: {
            self.collectionView.reloadData()
        })
        
    }
    
    func requestFailed(with error: Error, forRequest request: URLRequest) {
        print(error.localizedDescription)
        
        
        DispatchQueue.main.async(execute: {
            if( self.collectionView.isLoadingContent() ) {
                self.collectionView.stopLoadingIndicator()
            }
        })
    }
    
    func requestFailed(with error : Error, withIdentifier  ident : String ) {
    
        let indexPath : IndexPath = IndexPath(item: Int(ident)!, section: 1)
        if let collectionViewCell  : ProductCollectionViewCell = self.collectionView.cellForItem(at: indexPath) as? ProductCollectionViewCell {
            
            DispatchQueue.main.async(execute: {
                if( self.collectionView.isLoadingContent() ) {
                    self.collectionView.stopLoadingIndicator()
                }
                
                collectionViewCell.imageRequest = nil
                collectionViewCell.loader.stopAnimating()
            })
        }
        
        
        
        
            
            
    }

    
   
    

}

