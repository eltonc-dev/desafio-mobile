//
//  ProductDetailViewController.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 19/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController , RequestHandler ,
    UIPageViewControllerDelegate ,
    UIScrollViewDelegate {

    @IBOutlet weak var scrollview: UIScrollView!
    //@IBOutlet weak var containerImageViews: UIStackView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productOldPrice: UILabel!
    
    @IBOutlet weak var productInstallment: UILabel!
    
    var product : Product?
    
    @IBOutlet weak var productPrice: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.scrollview.delegate = self
        if( self.product != nil ) {
            self.productName.text = self.product?.name
            
            
        
            
            self.productOldPrice.text = "R$ \(String(format: "%.2f", arguments: [(self.product?.listPrice!)!]))"
            self.productPrice.text = "R$ \(String(format: "%.2f", arguments: [(self.product?.price!)!]))"
            
            self.productInstallment.text = self.product?.bestInstallment
            
            self.pageControl.numberOfPages = (self.product?.imagensUrl.count)!
            
            for var (index , _ ) in (self.product?.imagensUrl.enumerated())! {
                
                
                var imageSize : CGRect?
                
                if( index > 0) {
                    
                    imageSize = CGRect(x: self.scrollview.contentSize.width, y: 0, width: self.view.frame.size.width, height: self.scrollview.frame.size.height )
                    
                } else {
                    imageSize = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollview.frame.size.height )
                }
                
                let  imageView : UIImageView = UIImageView(frame: imageSize!)
                
                imageView.tag = index
                
                
                
                
                imageView.contentMode = .scaleAspectFill
                
                self.scrollview.contentSize.width = self.scrollview.contentSize.width + imageView.frame.size.width
                
                
        
                    self.scrollview.addSubview(imageView)
              
                
                
                
                _ = RequestHelper.loadImageFrom(imageUrl: (self.product?.getImageUrlFromItemAtPosition(position: index, size: Product.SizeImages.BIG))! , with: self, and: index )
                
                
            }
        }
        
    }

    
    // MARK: - Request Handler Methods
    
    func requestSuccess(with data: Any, forRequest request: URLRequest) {
        
    }
    
    func requestSuccess(with data: Any, withIdentifier ident: String) {
        //usado para imagens
        print("ident \(ident)")
        
        if let imageView = (self.scrollview.subviews[Int(ident)!] as? UIImageView) {
            print("tem imagem")
            DispatchQueue.main.async(execute: {
                imageView.image = data as? UIImage
            })

            
        }
        
    }
    
    func requestFailed(with error: Error, forRequest request: URLRequest) {
        
    }
    
    func requestFailed(with error : Error, withIdentifier  ident : String ) {
        
        
    }

    // MARK: - SCROLLVIEW
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        
        self.pageControl.currentPage = page
    }

}
