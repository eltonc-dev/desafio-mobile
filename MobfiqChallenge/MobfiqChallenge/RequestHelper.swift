//
//  RequestHelper.swift
//  MobfiqChallenge
//
//  Created by Elton Coelho on 20/08/17.
//  Copyright © 2017 Elton Coelho. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class RequestHelper: NSObject {
    
    struct Erros {
        static let ImageError = "erro_imagem"
    }
    
    static func hasInternetConnection() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    static private func request(on url: String, withMethod method: String, and handler: RequestHandler? ) -> URLSessionDataTask? {
        
        if( !url.isEmpty ) {
            print(url)
            let request = NSMutableURLRequest(url: URL(string: url)!)
            request.setValue("application/json;", forHTTPHeaderField: "Content-Type")
            request.httpMethod = method
            
            return resumeRequest(request: request as URLRequest, withHandler: handler)
            
        }
        return nil

    }
    
    
    
    private static func resumeRequest(request : URLRequest , withHandler handler: RequestHandler? ) -> URLSessionDataTask? {
        
        let requestTask = URLSession.shared.dataTask(with: request) { (data, response , error) in
            
            if( error != nil ) {
                print(error.debugDescription)
                if( handler != nil ) {
                    handler?.requestFailed(with: error!, forRequest: request as URLRequest)
                }
            } else {
                
                let parsedJson : AnyObject!
                do {
                    
                    parsedJson =  try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! AnyObject
                    //print(parsedJson)
                    
                    if( handler != nil ) {
                        handler?.requestSuccess(with: parsedJson, forRequest: request as URLRequest)
                    }
                    
                } catch {
                    print("Parser Error")
                    return
                }
                
                
            }
        }
        
        requestTask.resume()
        
        return requestTask
    
    }
    
    static func getRequest(on url:String, and handler: RequestHandler? ) -> URLSessionDataTask? {
            return request(on: url, withMethod: "GET", and: handler)
    }
    
    static func postRequest(on url:String, with params: NSDictionary, and handler: RequestHandler?) -> URLSessionDataTask? {
        
        do {
            let headers = [
                "content-type": "application/json"
            ]
            
            let dataParams =  try JSONSerialization.data(withJSONObject: params as! [String : Any], options: .prettyPrinted)
            
            
            if( !url.isEmpty ) {
                print(url)
                let request = NSMutableURLRequest(url: URL(string: url)!)
                
                request.httpBody = dataParams
                request.httpMethod = "POST"
                request.allHTTPHeaderFields = headers
                
                return resumeRequest(request: request as URLRequest, withHandler: handler)
                
            }
        } catch {
            print("Parser Error")
        }
        return nil
        
    }
    
    
    
    static func loadImageFrom(imageUrl: String, with handler : RequestHandler , and identifier : Int ) -> URLSessionDataTask? {
        //print(imageUrl)
        if( !imageUrl.isEmpty ) {
            
            let requestTask = URLSession.shared.dataTask( with: URL(string: imageUrl)! ) { (data, response , error) in
                
                if( error == nil ) {
                        handler.requestSuccess(with: UIImage(data:data!) , withIdentifier: String(identifier) )
                } else {
                    
                        handler.requestFailed(with: error! ,  withIdentifier: String(identifier))
                }
                
            }
            requestTask.resume()
            return requestTask
        }
        return nil
    }

}
