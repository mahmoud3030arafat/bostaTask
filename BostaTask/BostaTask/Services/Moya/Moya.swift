//
//  Moya.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import Foundation
import Moya

class NetworkManager<T: TargetType> {
    private let provider: MoyaProvider<T>

    init(provider: MoyaProvider<T> = MoyaProvider<T>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])) {
        self.provider = provider
    }

    func request<U: Decodable>(
        _ target: T,
        type: U.Type,
        completion: @escaping (Result<U, Error>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let filteredResponse = try response.filterSuccessfulStatusCodes()
                    let decodedData = try JSONDecoder().decode(U.self, from: filteredResponse.data)
                    completion(.success(decodedData))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
