//
//  API.swift
//  Robustivity
//
//  Created by Ahmed Mohamed Fareed on 2/24/16.
//  Copyright © 2016 BumbleBee. All rights reserved.
//

import Alamofire

class API: NSObject {
    
    private static var headers = [
        "Authorization": "Bearer 0d689882b114fffdc65aaa60f9128a63c9f17d8b3c8075553759e0cf2bd09892"
    ]
    
    private static func baseRequest(type: Alamofire.Method, url: String, parameters: [String: AnyObject]?, callback: (success: Bool, response: AnyObject) -> ()) {
        
        Alamofire.request(type, APIRoutes.BASE + url, headers: API.headers, parameters: parameters)
            .responseJSON { response in
                callback(success: response.result.isSuccess, response: response.result.value!)
        }
    }
    
    
    // MARK: BASIC Request
    static func get(url: String, callback: (success: Bool, response: AnyObject) -> ()) {
        
        baseRequest(.GET, url: url, parameters: nil, callback: callback)
        
    }
    
    static func post(url: String, parameters: [String: AnyObject], callback: (success: Bool, response: AnyObject) -> ()) {
        
        baseRequest(.POST, url: url, parameters: parameters, callback: callback)
   
        
    }
    
    static func delete(url: String, callback: (success: Bool, response: AnyObject) -> ()) {
        
        baseRequest(.DELETE, url: url, parameters: nil, callback: callback)
        
    }
    
    static func put(url: String, parameters: [String: AnyObject], callback: (success: Bool, response: AnyObject) -> ()) {
        
        baseRequest(.PUT, url: url, parameters: parameters, callback: callback)
        
    }
    
    // MARK: MULTIPART
    private static func baseMultipartRequest(type: Alamofire.Method, url: String, parameters: [String: AnyObject], callback: (success: Bool, response: AnyObject) -> ()) {
        
        func prepareParameters(multipartFormData: MultipartFormData) {
            for parameter in parameters {
                
                switch (parameter.1) {
                case let param as String:
                    multipartFormData.appendBodyPart(data: param.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: parameter.0)

                case let param as NSData:
                    multipartFormData.appendBodyPart(data: param, name: parameter.0)

                case let param as UIImage:
                    let imgData = UIImageJPEGRepresentation(param, 0.0);
                    multipartFormData.appendBodyPart(data: imgData!, name: parameter.0)
                    
                default: break
                }
            
            }
        }
        
        Alamofire.upload(
            type,
            APIRoutes.BASE + url,
            headers: headers,
            multipartFormData: prepareParameters,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        callback(success: response.result.isSuccess, response: response.result.value!)
                    }
                case .Failure(let encodingError):
                    print(encodingError)
                }
            }
        )

    }
    
    static func postMultipart(url: String, parameters: [String : AnyObject], callback: (Bool, AnyObject) -> ()) {
        baseMultipartRequest(.POST, url: url, parameters: parameters, callback: callback)
    }
    
    static func putMultipart(url: String, parameters: [String : AnyObject], callback: (Bool, AnyObject) -> ()) {
        baseMultipartRequest(.PUT, url: url, parameters: parameters, callback: callback)
    }
}
