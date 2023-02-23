//
//  ImageCell.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import UIKit

final class ImageCell: UICollectionViewCell {

    private lazy var photoView: UIImageView = {
        let view = UIImageView()
        return view
    }()

    var featuredPhotoURL: URL? {
        didSet {
            photoView.image = UIImage(contentsOfFile: featuredPhotoURL!.path)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = self.frame.height/10
    }

    private func prepare() {
        contentView.clipsToBounds = true
        preparePhotoView()
    }

    private func preparePhotoView() {
        contentView.addSubview(photoView)

        photoView.translatesAutoresizingMaskIntoConstraints = false
        photoView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

// MARK: - CollectionViewReusableCellProtocol

extension ImageCell: CollectionViewReusableCellProtocol {
    static let reuseIdentifier = "album-item-cell-reuse-identifier"
}
