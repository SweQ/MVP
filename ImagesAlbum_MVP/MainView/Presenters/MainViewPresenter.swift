//
//  MainViewPresenter.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 11.08.22.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
    func reloadTable()
}

protocol MainViewPresenterProtocol: AnyObject {
    var photos: [Photo] {get set}
    var networkService: NetworkServiceProtocol {get set}
    func getPhotos()
}

class MainViewPresenter: MainViewPresenterProtocol {
    var photos: [Photo]
    var networkService: NetworkServiceProtocol
    private let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
    
    weak var view: MainViewProtocol?
    
    init(view: MainViewProtocol) {
        self.view = view
        networkService = NetworkService()
        photos = []
        getPhotos()
    }
    
    func getPhotos() {
        guard let url = url else {
            return
        }

        networkService.getPhotos(from: url) { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                DispatchQueue.main.async {
                    self?.view?.reloadTable()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
}
