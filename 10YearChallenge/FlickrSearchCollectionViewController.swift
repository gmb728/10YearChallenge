//
//  FlickrSearchCollectionViewController.swift
//  10YearChallenge
//
//  Created by Chang Sophia on 1/19/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit
var timer: Timer?
var goal: Date!

private let reuseIdentifier = "Cell"

class FlickrSearchCollectionViewController: UICollectionViewController {

    var photos = [Photo]()
    
    func fetchData(){
        
        if let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=3eaa4d1a509a5573091df54a6f00a584&text=ChristianBale&per_page=2&format=json&nojsoncallback=1") {
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    @IBAction func datePickerAction(_ sender: Any) {
        datePicker.backgroundColor = .black
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        fetchData()
        

}
