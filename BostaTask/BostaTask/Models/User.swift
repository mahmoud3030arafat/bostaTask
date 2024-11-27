//
//  User.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import Foundation

// Root model for the user
struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

// Address model
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

// Geo model
struct Geo: Codable {
    let lat: String
    let lng: String
}

// Company model
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
