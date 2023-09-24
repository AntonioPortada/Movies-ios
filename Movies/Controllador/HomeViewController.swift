//
//  HomeViewController.swift
//  Movies
//
//  Created by Antonio Portada on 14/09/23.
//

import UIKit
import FirebaseAuth
import Kingfisher

class HomeViewController: UIViewController {

    // MARK: - IBOulet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - variables locales
    let defaults = UserDefaults.standard
    let manager = MoviesManager()
    
    var peliculas: [DataMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "celda")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        defaults.set("logueado", forKey: "sesionIniciada")
        
        getPeliculas()
        
        
    }
    
    // MARK: IBAction
    @IBAction func btnSalir(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            defaults.removeObject(forKey: "sesionIniciada")
            goToLogin()
        }
        catch {
            print("error al cerrar sesión de firebase. \(error.localizedDescription)")
        }
    }
    
    private func setupCollection() {
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    func goToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        self.present(viewController, animated: true)
    }
    
    func getPeliculas() {
        manager.getPopularMovies { listado in
            self.peliculas = listado
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// Mark: - CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! MovieCollectionViewCell
        
        if let url = URL(string: "\(Constants.urlImages)\(peliculas[indexPath.row].poster_path!)") {
            celda.posterMovie.kf.setImage(with: url)
        }
        
        celda.titleMovie.text = peliculas[indexPath.row].title
        celda.dateMovie.text = peliculas[indexPath.row].release_date
        celda.descriptionMovie.text = peliculas[indexPath.row].overview
        
        return celda
    }
}

// MARK: -
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 195, height: 320)
    }
}
