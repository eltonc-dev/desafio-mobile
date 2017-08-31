//
//  Constants.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 20/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

struct Constants {
    
    // MARK: - USER DEFAULT
    struct UserDefault {
        
        static let KEY_FAVORITE_PRODUCTS : String = "favorite_produts"
        static let KEY_SEARCHES : String = "user_searches"
    }
    
    // MARK: - URLS
    struct Url {
        
        static let BASE : String = "https://desafio.mobfiq.com.br"
        
        static let CATEGORY : String = "\(Constants.Url.BASE)/StorePreference/CategoryTree"
        static let PRODUCTS : String = "\(Constants.Url.BASE)/Search/Criteria"
    }
    
    // MARK: - URL PARAMS
    struct UrlParams {
        
        static let OFFSET : String = "Offset"
        static let SIZE : String = "Size"
        static let QUERY : String = "Query"
        
        static let PRODUCTS : String = "Products"
        static let TOTAL_PRODUCTS : String = "Total"
        
    }
    
    // MARK: - Category
    struct Category {
        static let Categories : String = "Categories"
    }
}
