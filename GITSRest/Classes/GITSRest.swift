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
    public static func runRequest(urlRequest : URLRequest, jsonValidation : ((JSON) -> (GITSRestError?))? = nil, callback : @escaping (GITSRestError?, JSON?) -> ()) -> DataRequest
    {
        var req = request(urlRequest).responseJSON { response in
            var json : JSON?
            var err : GITSRestError?
            switch response.result {
            case .success(let value) :
                json = JSON(value)
            case .failure(let error) :
                if let nserror = error as? NSError
                {
                    if nserror.code == -1001
                    {
                        err = .timeout
                    } else if nserror.code == 401 {
                        err = .unauthorized
                    } else {
                        err = .serverFailure(code: nserror.code, message: nserror.localizedDescription)
                    }
                }
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
