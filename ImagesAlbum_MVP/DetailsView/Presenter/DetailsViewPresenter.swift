//
//  DetailsViewPresenter.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 13.08.22.
//

import Foundation
import UIKit

protocol DetailsViewProtocol: AnyObject {
    func showImagePhoto(image: UIImage)
    func showTitlePhoto(title: String)
}

protocol DetailsViewPresenterProtocol: AnyObject {
    var photo: Photo { get set }
    var view: DetailsViewProtocol? { get set }
    func downloadImage()
    func loadPhotoTitle()
}

class DetailsViewPresenter: DetailsViewPresenterProtocol {
    
    var photo: Photo
    weak var view: DetailsViewProtocol?
    
    init(photo: Photo, view: DetailsViewProtocol) {
        self.photo = photo
        self.view = view
    }
    
    func loadPhotoTitle() {
        let title = photo.title
        view?.showTitlePhoto(title: title)
    }
    
    func downloadImage() {
        guard let imageURL = URL(string: photo.url) else { return }
        NetworkService().getImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.view?.showImagePhoto(image: image)
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
}
