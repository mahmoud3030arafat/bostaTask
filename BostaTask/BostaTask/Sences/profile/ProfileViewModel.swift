//
//  ProfileViewModel.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import UIKit
import Moya
import RxSwift
import RxRelay

final class profileViewModel: BaseViewModel {
    // Properties
    var albums = BehaviorRelay<[Album]>(value: [Album]())
    var users = BehaviorRelay<[User]>(value: [User]())
    let provider = MoyaProvider<MyAPI>()
    let networkManager = NetworkManager<MyAPI>()

    func getAlbums(id: Int) {
        networkManager.request(.getAlbums(userId: id), type: [Album].self) { result in
            switch result {
            case .success(let albums):
                print("Fetched albums: \(albums)")
                self.albums.accept(albums)
            case .failure(let error):
                print("Error fetching albums: \(error)")
            }
        }
    }
    
    func getUsers(){
        networkManager.request(.getUsers, type: [User].self) { result in
            switch result {
            case .success(let users):
                self.users.accept(users)
            case .failure(let error):
                print("Error fetching users: \(error)")
            }
        }
        
    }
    
}

