//
//  AlamofireAttributes.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Alamofire

typealias Params = [String: Any]
typealias URLConvertible = URLRequestConvertible
typealias Headers = HTTPHeaders
typealias NetworkSession = Session
typealias ReachabilityManager = NetworkReachabilityManager
typealias URLEncoder = URLEncoding

let NetworkInstance = Session.default
