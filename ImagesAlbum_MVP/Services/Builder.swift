//
//  Builder.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 13.08.22.
//

import Foundation
import UIKit

protocol BuilderProtocol {
    static func createMainView() -> UIViewController
    static func createDetailsView(photo: Photo) -> UIViewController
}

class Builder: BuilderProtocol {

    
    static func createMainView() -> UIViewController {
        let mainView = MainViewController()
        let mainPresenter = MainViewPresenter(view: mainView)
        mainView.presenter = mainPresenter
        
        return mainView
    }
    
    static func createDetailsView(photo: Photo) -> UIViewController {
        let detailsView = DetailsViewController()
        let detailsPresenter = DetailsViewPresenter(photo: photo, view: detailsView)
        detailsView.presenter = detailsPresenter
        
        return detailsView
    }
    
    
}
