//
//  FavoriteHandler.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 20/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import Foundation

protocol FavoriteHandler {
    
    func saveAsFavorite(_ element : Any)
    func removeFromFavorite(_ element : Any)
    
}
