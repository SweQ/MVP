//
//  PhotoCellPresenter.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 11.08.22.
//

import Foundation
import UIKit

protocol PhotoCellProtocol: AnyObject {
    var presenter: PhotoCellPresenterProtocol? {get set}
}

protocol PhotoCellPresenterProtocol: AnyObject {
    var networkService: NetworkServiceProtocol {get set}
    var cell: PhotoCellProtocol {get set}
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void)
}

class PhotoCellPresenter: PhotoCellPresenterProtocol {
    var cell: PhotoCellProtocol
    var networkService: NetworkServiceProtocol
    
    init(cell: PhotoCellProtocol) {
        self.cell = cell
        networkService = NetworkService()
    }
    
    func downloadImage(url: String, completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = URL(string: url) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        networkService.getImage(from: imageURL) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    completion(image)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
