# **MVP App**
I used **MVP** pattern in this project for studying.
____
## **Description of some components**:

```swift
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
```
---
```swift
protocol MainViewPresenterProtocol: AnyObject {
    var photos: [Photo] {get set}
    var networkService: NetworkServiceProtocol {get set}
    func getPhotos()
}

protocol MainViewProtocol: AnyObject {
    func reloadTable()
}
```
---
```swift
protocol DetailsViewPresenterProtocol: AnyObject {
    var photo: Photo { get set }
    var view: DetailsViewProtocol? { get set }
    func downloadImage()
    func loadPhotoTitle()
}

protocol DetailsViewProtocol: AnyObject {
    func showImagePhoto(image: UIImage)
    func showTitlePhoto(title: String)
}
```
---
```swift
protocol NetworkServiceProtocol {
    var downloadImageDataTask: URLSessionDataTask? {get set}
    func getPhotos(from url: URL, completion: @escaping (Result<[Photo], Error>) -> Void)
    func getImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}
```

