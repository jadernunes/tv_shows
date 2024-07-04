//
//  NetworkSession.swift
//
//  Created by Jader Nunes on 23/06/24.
//

import Foundation
import Alamofire

public enum HTTPMethodType: String, CaseIterable {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

public protocol INetwork {
    func makeRequest<T: Decodable>(requester: Requestable) async throws -> T
}

extension NetworkSession: INetwork {
    
    public func makeRequest<T: Decodable>(requester: Requestable) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            guard let isReachable = ReachabilityManager.default?.isReachable, isReachable
            else {
                continuation.resume(with: .failure(NetworkErrorType.noInternet))
                return
            }
            
            printRequest(request: requester)
            request(requester)
                .validate()
                .responseDecodable(
                    queue: DispatchQueue.global(qos: .userInitiated),
                    decoder: JSONDecoder.decoder) { (response: DataResponse<T, AFError>) in
                        DispatchQueue.main.async {
                            switch response.result {
                            case .success(let value):
                                continuation.resume(with: .success(value))
                            case .failure(let error):
                                continuation.resume(with: .failure(error))
                            }
                        }
                    }
        }
    }
}

private func printRequest(request: Requestable?) {
    #if DEBUG
    print("\n\n**********  REQUEST   **************")
    print("\(request?.urlRequest?.httpMethod ?? "") - URL: ", request?.urlRequest?.url ?? "")
    print("HEADER: ", request?.urlRequest?.allHTTPHeaderFields?.toJson() ?? "")
    print("BODY: ", request?.parameters ?? "")
    print("****************************************\n\n")
    #endif
}
