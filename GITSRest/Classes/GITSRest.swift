//
//  GITSRest.swift
//  Pods
//
//  Created by Rahadian on 3/8/17.
//
//

import UIKit
import Alamofire
import SwiftyJSON

public class GITSRest
{
    public static func runRequest(urlRequest : URLRequest, jsonValidation : ((JSON) -> (Error?))? = nil, callback : @escaping (Error?, JSON?) -> ()) -> DataRequest
    {
        var req = request(urlRequest).responseJSON { response in
            var json : JSON?
            var err : Error?
            switch response.result {
            case .success(let value) :
                json = JSON(value)
            case .failure(let error) :
                err = error
            }
            
            if let validator = jsonValidation, let jsonData = json, err == nil
            {
                if let error = validator(jsonData)
                {
                    err = error
                }
            }
            
            callback(err, json)
        }
        
        return req
    }
}
