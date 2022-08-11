//
//  PhotoTableViewCell.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 11.08.22.
//

import UIKit

class PhotoTableViewCell: UITableViewCell, PhotoCellProtocol {

    static let identifier = "PhotoTableViewCell"
    var photoView: UIImageView = UIImageView()
    var titleLable: UILabel = UILabel()
    var presenter: PhotoCellPresenterProtocol?
    
    func configure(with photo: Photo) {
        presenter = PhotoCellPresenter(cell: self)
        setupTitleLabel(with: photo.title)
        setupPhotoView(with: photo.thumbnailUrl)
    }
    
    private func setupPhotoView(with url: String) {
        
        contentView.addSubview(photoView)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            photoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            photoView.rightAnchor.constraint(equalTo: titleLable.leftAnchor, constant: -10),
            photoView.widthAnchor.constraint(equalTo: photoView.heightAnchor)
        ])
        
        presenter?.downloadImage(url: url, completion: { [weak self] image in
            self?.photoView.image = image
        })
    }
    
    private func setupTitleLabel(with title: String) {
        
        contentView.addSubview(titleLable)
        
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLable.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
        
        titleLable.text = title
    }
    
    
    override func prepareForReuse() {
        self.photoView.image = nil
        self.titleLable.text = nil
    }

}
