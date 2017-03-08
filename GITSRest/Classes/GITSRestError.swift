//
//  GITSRestError.swift
//  Pods
//
//  Created by Rahadian on 3/8/17.
//
//

import Foundation

public enum GITSRestError : Equatable
{
    case unknown
    case timeout
    case serverFailure(code : Int, message : String)
    case unauthorized
    
    func order() -> Int
    {
        switch self
        {
        case .unknown :
            return 1
        case .timeout :
            return 2
        case .serverFailure(let code, _) :
            return code
        case .unauthorized :
            return 3
        }
    }
}

public func ==(left: GITSRestError, right: GITSRestError) -> Bool
{
    return left.order() == right.order()
}
