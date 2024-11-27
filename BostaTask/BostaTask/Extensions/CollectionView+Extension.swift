//
//  CollectionView+Extension.swift
//  BostaTask
//
//  Created by Blinkappp on 26/11/2024.
//

import UIKit

extension UICollectionView: Reusable {

    func registerNib<Cell: UICollectionViewCell>(cell: Cell.Type) {
        let nibName = Cell.identifier
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell else {
            fatalError("Error in cell")
        }
        return cell
    }
}

extension UICollectionViewCell: Reusable {}
