//
//  Photo.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import Foundation

struct Photo: Codable {
    let albumIdentifier: Int
    let photoId: Int
    let photoTitle: String
    let imageUrl: String
    let thumbnailImageUrl: String

    enum CodingKeys: String, CodingKey {
        case albumIdentifier = "albumId"
        case photoId = "id"
        case photoTitle = "title"
        case imageUrl = "url"
        case thumbnailImageUrl = "thumbnailUrl"
    }
}

