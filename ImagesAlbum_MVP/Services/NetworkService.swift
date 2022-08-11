//
//  NetworkService.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 11.08.22.
//

import UIKit

protocol NetworkServiceProtocol {
    var downloadImageDataTask: URLSessionDataTask? {get set}
    func getPhotos(from url: URL, completion: @escaping (Result<[Photo], Error>) -> Void)
    func getImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    var downloadImageDataTask: URLSessionDataTask?

    var urlSession = URLSession.shared
    
    
    func getPhotos(
        from url: URL,
        completion: @escaping (Result<[Photo], Error>) -> Void
    ) {
        
        urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if let data = data,
               let photos = try? JSONDecoder().decode([Photo].self, from: data)
            {
                DispatchQueue.main.async {
                    completion(.success(photos))
                }
            }

            
        }.resume()
    }
    
    func getImage(
        from url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) {
        if downloadImageDataTask != nil {
            downloadImageDataTask?.cancel()
        }
        
        downloadImageDataTask = urlSession.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
                return
            }
            
            if let data = data,
               let image = UIImage(data: data)
            {
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
        }
        downloadImageDataTask?.resume()
        
    }
    
    
}
