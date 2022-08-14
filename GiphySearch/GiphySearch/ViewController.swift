//
//  ViewController.swift
//  GiphySearch
//
//  Created by  DNS on 12.08.2022.
//

import UIKit

struct APIResponse: Codable {
    let data: [DataRequest]
}

struct DataRequest: Codable {
    let id: String
    let embed_url: String
}

class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {
    
    private var collectionView: UICollectionView?
    
    var data: [DataRequest] = []
    
    let searchbar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        view.addSubview(searchbar)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(GifCollectionViewCell.self,
                                forCellWithReuseIdentifier: GifCollectionViewCell.identifier)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchbar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width-20, height: 50)
        collectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top+55, width: view.frame.size.width, height: view.frame.size.height-55)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        if let text = searchbar.text {
            data = []
            collectionView?.reloadData()
            fetchGif(query: text)
        }
    }
    
    func fetchGif(query: String) {
        let urlString = "https://api.giphy.com/v1/gifs/search?api_key=pntHIWtvzLdR8APKnp3L8SuFavSwTIIg&q=\(query)&limit=8&offset=0&rating=g&lang=en"
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let dataRequest = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.data = dataRequest.data
                    self?.collectionView?.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let gifUrl = data[indexPath.row].embed_url
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GifCollectionViewCell.identifier,
            for: indexPath
        ) as? GifCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: gifUrl)
        print(gifUrl)
        return cell
    }

}
