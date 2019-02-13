//
//  PhotoArray.swift
//  10YearChallenge
//
//  Created by Chang Sophia on 1/19/19.
//  Copyright © 2019 Chang Sophia. All rights reserved.
//

import Foundation

struct Media: Decodable {
    let m: URL
}
struct Item: Decodable {
    let title: String
    let media: Media
}
struct FeedData: Decodable {
    let itmes: [Item]
}

        
