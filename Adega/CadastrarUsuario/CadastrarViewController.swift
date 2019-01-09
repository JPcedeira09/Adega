//
//  CadastrarViewController.swift
//  Adega
//
//  Created by Joao Paulo on 08/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase

class CadastrarViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cadatrabtn: UIButton!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
     @IBAction func createAccountAction(_ sender: AnyObject) {
     
     if emailTextField.text == "" {
     let alertController = UIAlertController(title: "Erro", message: "Por favor, digite seu e-mail e senha.", preferredStyle: .alert)
     
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alertController.addAction(defaultAction)
     
     present(alertController, animated: true, completion: nil)
     
     } else {
     Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
     
     if error == nil {
     print("Voce foi cadastrado com sucesso")
     
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
     self.present(vc!, animated: true, completion: nil)
     
     } else {
     let alertController = UIAlertController(title: "Erro", message: error?.localizedDescription, preferredStyle: .alert)
     
     let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
     alertController.addAction(defaultAction)
     
     self.present(alertController, animated: true, completion: nil)
                }
             }
         }
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cadatrabtn.layer.cornerRadius = 4
    }
    
}
