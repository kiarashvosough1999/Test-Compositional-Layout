//
//  HeaderView.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import UIKit

final class HeaderView: UICollectionReusableView {

    private lazy var label: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.adjustsFontForContentSizeCategory = true
        view.font = UIFont.preferredFont(forTextStyle: .title3)
        view.textColor = .black
        return view
    }()

    var text: String? {
        didSet {
            label.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareView()
    }

    private func prepareView() {
        backgroundColor = .systemBackground
        
        prepareLabel()
    }

    private func prepareLabel() {
        addSubview(label)

        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
    }
}

extension HeaderView: CollectionViewReusableViewCellProtocol {
    static let elementKind: String = UICollectionView.elementKindSectionHeader
    static let reuseIdentifier = "header-reuse-identifier"
}
