//
//  RegistroViewController.swift
//  Movies
//
//  Created by Antonio Portada on 12/09/23.
//

import UIKit
import FirebaseAuth

class RegistroViewController: UIViewController {

    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    // MARK: - IBAction
    @IBAction func aceptarButton(_ sender: Any) {
        if let email = txtUser.text, let password = txtPassword.text {
            Auth.auth().createUser(withEmail: email, password: password) { resutl, error in
                
                //usuario creado
                if error != nil {
                    print("error al crear el usuario \(error.debugDescription)")
                    self.showAlert(title: "Atención", message: "Ocurrio un error al registrar el usuario. \(error!.localizedDescription)")
                }
                else {
                    self.performSegue(withIdentifier: "goToHomeSegue", sender: self)
                }
            }
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
