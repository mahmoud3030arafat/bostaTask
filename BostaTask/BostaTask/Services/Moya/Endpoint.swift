//
//  Endpoint.swift
//  BostaTask
//
//  Created by Blinkappp on 27/11/2024.
//

import Foundation
import Moya

enum MyAPI {
    case getUsers
    case getAlbums(userId: Int)
    case getPhotos(albumId: Int)
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getAlbums:
            return "/albums"
        case .getPhotos:
            return "/photos"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .getAlbums(let userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
        case .getPhotos(let albumId):
            return .requestParameters(parameters: ["albumId": albumId], encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
