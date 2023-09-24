//
//  MovieDataModel.swift
//  Movies
//
//  Created by Antonio Portada on 21/09/23.
//

import Foundation

struct MovieDataModel: Codable {
    
    let results: [DataMovie]
}

struct DataMovie: Codable {
    
    let backdrop_path: String?
    let id: Int?
    let original_title: String?
    let overview: String?
    let original_lenguage: String?
    let title: String?
    let release_date: String?
    let poster_path: String?
}
