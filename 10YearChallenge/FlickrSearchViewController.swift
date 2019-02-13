//
//  FlickrSearchCollectionViewController.swift
//  10YearChallenge
//
//  Created by Chang Sophia on 1/19/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"


class FlickrSearchViewController: UICollectionViewController {
    
    
    
    
    var photos = [Photo]()
    
   
    
    func fetchData(){
        
        if let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=cf83f916ccf1157ed6debae5f8ad8d80&user_id=8055924%40N08&format=json&nojsoncallback=1&auth_token=72157706593023505-4f6470ebef701e67&api_sig=cd72a5f5f6b43d79d608b45a3fc00675") {
            let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
                
                if let data = data, let searchData = try? JSONDecoder().decode(SearchData.self, from: data) {
                  self.photos = searchData.photos.photo
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = (view.bounds.width - 10) / 2
        layout?.itemSize = CGSize(width: width, height: width + 80)
        
        fetchData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        // Configure the cell
        let photo = photos[indexPath.item]
        cell.titleLabel.text = photo.title
        cell.imageURL = photo.imageUrl
        cell.photoImageView.image = nil
        NetworkUtility.downloadImage(url: cell.imageURL) { (image) in
            if cell.imageURL == photo.imageUrl, let image = image  {
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        
        return cell
    }

}
