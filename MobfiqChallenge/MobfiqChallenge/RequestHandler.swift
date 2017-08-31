//
//  RequestHandler.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 20/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import Foundation

protocol RequestHandler {
    
    func requestSuccess(with data: Any, forRequest request: URLRequest)
    func requestSuccess(with data: Any,  withIdentifier ident : String )
    func requestFailed(with error : Error, forRequest request: URLRequest)
    func requestFailed(with error : Error,  withIdentifier  ident : String )
}
