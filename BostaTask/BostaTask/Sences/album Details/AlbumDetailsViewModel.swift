//
//  AlbumDetailsViewModel.swift
//  BostaTask
//
//  Created by Blinkappp on 25/11/2024.
//

import Foundation
import UIKit
import Moya
import RxSwift
import RxRelay

final class AlbumDetailsViewModel: BaseViewModel {
    // Properties
    var photos = BehaviorRelay<[Photo]>(value: [Photo]())
    var filteredPhotos = BehaviorRelay<[Photo]>(value: [])
    let networkManager = NetworkManager<MyAPI>()
    private let albumId: Int
    
    // Initializer
    init(albumId: Int) {
        self.albumId = albumId
    }
    
    func getPhotos(albumId: Int) {
        networkManager.request(.getPhotos(albumId: albumId), type: [Photo].self) { result in
            switch result {
            case .success(let photos):
                self.photos.accept(photos)
                self.filteredPhotos.accept(photos)
            case .failure(let error):
                print("Error fetching photos: \(error.localizedDescription)")
            }
        }
    }

    
}

