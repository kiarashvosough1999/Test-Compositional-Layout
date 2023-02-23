//
//  CellProtocol.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import UIKit

protocol CollectionViewItemProtocol {
    static var reuseIdentifier: String { get }
}

protocol CollectionViewReusableCellProtocol: UICollectionViewCell, CollectionViewItemProtocol {}
protocol CollectionViewReusableViewCellProtocol: UICollectionReusableView, CollectionViewItemProtocol {
    static var elementKind: String { get }
}

extension UICollectionView {

    func register(cellClass: CollectionViewReusableCellProtocol.Type) {
        self.register(cellClass, forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }

    func register(viewClass: CollectionViewReusableViewCellProtocol.Type) {
        self.register(viewClass, forSupplementaryViewOfKind: viewClass.elementKind, withReuseIdentifier: viewClass.reuseIdentifier)
    }
}
