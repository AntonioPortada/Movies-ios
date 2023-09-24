//
//  HomeViewController.swift
//  Movies
//
//  Created by Antonio Portada on 14/09/23.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    // MARK: - IBOulet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - variables locales
    var peliculas: [DataMovie] = []
    
    let defaults = UserDefaults.standard
    let manager = MoviesManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "celda")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        defaults.set("logueado", forKey: "sesionIniciada")
        
        manager.getPopularMovies { listado in
            print("número de pelīculas: \(listado.count)")
        }
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
    
    func goToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        
        self.present(viewController, animated: true)
    }
}

// Mark: - CollectionView
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! MovieCollectionViewCell
        
        celda.posterMovie = 
    }
}
