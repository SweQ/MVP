//
//  DetailsViewController.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 13.08.22.
//

import UIKit

class DetailsViewController: UIViewController, DetailsViewProtocol {
    
    var presenter: DetailsViewPresenterProtocol!
    
    private var imageView: UIImageView!
    private var detailsLabel: UILabel!
    private var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupImageView()
        setupLabel()
        setupActivityIndicator()
        presenter.loadPhotoTitle()
        presenter.downloadImage()
    }
    
    func showImagePhoto(image: UIImage) {
        imageView.image = image
        activityIndicator.stopAnimating()
    }
    
    func showTitlePhoto(title: String) {
        detailsLabel.text = title
    }

}

//MARK: -Setup elements
extension DetailsViewController {
    private func setupImageView() {
        imageView = UIImageView()
        
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        
        imageView.addSubview(activityIndicator)
        
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    private func setupLabel() {
        detailsLabel = UILabel()
        
        view.addSubview(detailsLabel)
        
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailsLabel.numberOfLines = 0
        detailsLabel.minimumScaleFactor = 0.2
        detailsLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            detailsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            detailsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            detailsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
}
