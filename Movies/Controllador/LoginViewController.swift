//
//  ViewController.swift
//  Movies
//
//  Created by Antonio Portada on 30/08/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.string(forKey: "sesionIniciada") != nil {
            self.performSegue(withIdentifier: "loginGoToHomeSegue", sender: self)
        }
    }

    // MARK: - IBAction
    @IBAction func btnLogin(_ sender: Any) {
        if let email = txtUser.text, let password = txtPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) { response, error in
                
                if error != nil {
                    print("Sucedio un error. \(error!.localizedDescription)")
                    self.showAlert(title: "Atención", message: "Ocurrio un error. \(error!.localizedDescription)")
                }
                else {
                    self.performSegue(withIdentifier: "loginGoToHomeSegue", sender: self)
                }
            }
        }
    }
    
    // MARK: - métodos
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionAcept = UIAlertAction(title: "OK", style: .default) {_ in
            
        }
        
        alert.addAction(actionAcept)
        present(alert, animated: true)
    }
}

