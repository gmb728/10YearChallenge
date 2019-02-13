//
//  PhotoController.swift
//  10YearChallenge
//
//  Created by Chang Sophia on 1/19/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import UIKit

class PhotoController: UIControl {
    static let shared = PhotoController()
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (date, response, error) in
            if let data = data,
                let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    var photoArry = [Photo]()
    func fetchSongs(completion: @escaping [Photo]?) -> Void {
        if let urlStr = "".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr) {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let resultArry = (try? JSONSerializationjsonObject(with:data, options[])) as? [[String: Any]]
                {
                    print(resultArray)
                    for photoDic in resultArray {
                        if let photo = Photo(json: photoDic as! [String: String]) {
                            self.photoArray.append(photo)
                        }
                    }
                    completion(self.photoArray)
                }
            }
            task.resume()
        }
    }
    

}
