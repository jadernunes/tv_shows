//
//  Requestable.swift
//  tvshows
//
//  Created by Jader Borba Nunes on 03/04/24.
//

import Foundation

protocol Requestable: URLConvertible {
    var method: HTTPMethodType { get }
    var parameters: Params? { get }
    var path: String { get }
    var headers: Headers { get }

    func asURLRequest() throws -> URLRequest
}

extension Requestable {

    // MARK: - Properties

    var parameters: Params? { nil }
    var headers: Headers { [] }

    // MARK: - Methods

    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: Config.baseURL) else {
            throw NetworkErrorType.missingURL
        }

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        try urlRequest.setUpParams(parameters, method: method, request: urlRequest)
        
        return urlRequest
    }
}

// MARK: - URLResquest

private extension URLRequest {
    
    mutating func setUpParams(_ parameters: Params?, method: HTTPMethodType, request: URLRequest) throws {
        if let parameters {
            do {
                switch method {
                case .get:
                    self = try URLEncoder.default.encode(request, with: parameters)
                case .post, .patch, .delete:
                    httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }
            } catch {
                throw NetworkErrorType.jsonEncodingFailed(error: error)
            }
        }
    }
}
