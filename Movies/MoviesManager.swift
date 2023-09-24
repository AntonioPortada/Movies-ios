//
//  MoviesManager.swift
//  Movies
//
//  Created by Antonio Portada on 21/09/23.
//

import Foundation

struct MoviesManager {
    
    func getPopularMovies(completion: @escaping ([DataMovie]) -> Void) {
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=2cfa8720256036601fb9ac4e4bce1a9b&language=es-MX&page=1") else { return }
        
        let tarea = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                
                completion([])
                return
            }
            
            do {
                let dataDecodifica = try JSONDecoder().decode(MovieDataModel.self, from: data)
                let listaPeliculas = dataDecodifica.results
                
                completion(listaPeliculas)
            }
            catch {
                print("error en decodable")
                completion([])
            }
        }
        
        tarea.resume()
    }
}
