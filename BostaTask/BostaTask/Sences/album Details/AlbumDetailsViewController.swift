//
//  AlbumDetailsViewController.swift
//  BostaTask
//
//  Created by Blinkappp on 25/11/2024.
//

import UIKit
import RxSwift
import Moya
import RxRelay

class AlbumDetailsViewController: UIViewController {
    // Outlets
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Properties
    var albumId: Int!
    var albumtitle: String!
    var viewModel: AlbumDetailsViewModel!
    let disposeBag = DisposeBag()
    var filteredPhotos = BehaviorRelay<[Photo]>(value: [])
    
    init(albumId: Int) {
          super.init(nibName: nil, bundle: nil)
          self.viewModel = AlbumDetailsViewModel(albumId: albumId) 
      }

      required init?(coder: NSCoder) {
          super.init(coder: coder)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPhotos(albumId: albumId)
        subscribeToResponse()
        setupView()
    }
    
   private func setupView() {
        configureCollectionView()
        configureSearchBar()
        configureAlbumTitle()
    }

    private func configureCollectionView() {
        collectionView.registerNib(cell: PhotoCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search in images.."
    }

    private func configureAlbumTitle() {
        albumTitle.text = albumtitle
    }

    private func subscribeToResponse() {
        viewModel.filteredPhotos.subscribe(onNext: { [weak self] (Photos) in
            guard let self = self else {return}
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredPhotos.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeue(indexPath: indexPath) as PhotoCollectionViewCell
        cell.setup(with: viewModel.filteredPhotos.value[indexPath.row])
        return cell
    }
    
    
    
    // MARK: - UICollectionViewDelegateFlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 0 // Spacing between cells
        let totalSpacing = spacing * 4 // 3 cells, so 4 spacings (left, right, 2 between cells)
        
        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = availableWidth / 3 // Divide available width by 3 for 3 cells
        return CGSize(width: cellWidth, height: cellWidth) // Square cells
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Vertical spacing between rows
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // Horizontal spacing between cells
    }
    
}


extension AlbumDetailsViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // If search text is empty, show all photos
            viewModel.filteredPhotos.accept(viewModel.photos.value)
        } else {
            // Filter photos based on the search text
            let filtered = viewModel.photos.value.filter {
                $0.photoTitle.lowercased().contains(searchText.lowercased())
            }
            viewModel.filteredPhotos.accept(filtered)
        }
    }
    
}
