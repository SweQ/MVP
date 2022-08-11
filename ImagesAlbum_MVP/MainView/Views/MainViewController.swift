//
//  MainViewController.swift
//  ImagesAlbum_MVP
//
//  Created by alexKoro on 11.08.22.
//

import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainViewPresenterProtocol!
    
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main VC"
        navigationController?.navigationBar.prefersLargeTitles = true
        presenter = MainViewPresenter(view: self)
        setupTableView()
    }
}

//MARK: -Setup elements
extension MainViewController {
    
    //Setup tableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        setupTableViewAnchors()
    }
    
    private func setupTableViewAnchors() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: -TableViewExtensions
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let photoCell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier) as? PhotoTableViewCell else {
            return UITableViewCell()
        }
        
        let photo = presenter.photos[indexPath.row]
        
        photoCell.configure(with: photo)
        
        return photoCell
    }
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}

//MARK: -MainViewProtocolExtension
extension MainViewController: MainViewProtocol {
    func reloadTable() {
        tableView.reloadData()
    }
}
