//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import UIKit
import Moya
import RxSwift
import RxRelay

class ProfileViewController: UIViewController {
    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    // properties
    let provider = MoyaProvider<MyAPI>()
    var viewModel = profileViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUsers()
        subscribeToUsersResponse()
        subscribeToResponse()
        setupView()
    }
    
    private func setupView() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.registerNib(cell: ProfileTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
    }
    
    private func subscribeToResponse() {
        viewModel.albums.subscribe(onNext: { [weak self] (_) in
            guard let self = self else {return}
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
    }
    
    private func subscribeToUsersResponse() {
        viewModel.users
            .compactMap { $0.first }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] user in
                self?.handleUserResponse(user)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleUserResponse(_ user: User) {
        let name = user.name
        let address = createFullAddress(from: user.address) ?? ""
        configureUserInfo(name: name, address: address)
        fetchAlbums(for: user.id)
    }
    
    private func fetchAlbums(for userId: Int) {
        viewModel.getAlbums(id: userId)
    }
    
    
    private func configureUserInfo(name: String,address: String) {
        userName.text = name
        userAddress.text = address
    }
    
    private func createFullAddress(from address: Address?) -> String? {
        guard let address = address else { return nil }
        return "\(address.street), \(address.suite), \(address.city), \(address.zipcode)"
    }
        
}

extension ProfileViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.albums.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as ProfileTableViewCell
        cell.setup(with: viewModel.albums.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAlbum = viewModel.albums.value[indexPath.row]
        let viewController = AlbumDetailsViewController(albumId: selectedAlbum.id)
        viewController.albumId = selectedAlbum.id
        viewController.albumtitle = selectedAlbum.title
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
        
    }
    
}

