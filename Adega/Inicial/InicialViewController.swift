//
//  InicialViewController.swift
//  Adega
//
//  Created by Joao Paulo on 08/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase

class InicialViewController: UIViewController {

    @IBOutlet weak var entrabtn: UIButton!
    @IBOutlet weak var cadastrabtn: UIButton!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var senha: UITextField!
    
    @IBAction func loginAction(_ sender: AnyObject) {
        
        if self.email.text == "" || self.senha.text == "" {
            
            let alertController = UIAlertController(title: "Erro", message: "Por favor, digite seu e-mail e senha.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else if self.email.text == "adega.house@gmail.com" || self.senha.text == "Adega123"{
            
            print("O Dono da Adega foi logado com sucesso.")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeDono")
            self.present(vc!, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.email.text!, password: self.senha.text!) { (user, error) in
                if error == nil {
                  
                    print("Voce foi logado com sucesso.")
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
        entrabtn.layer.cornerRadius = 4
        cadastrabtn.layer.cornerRadius = 4
    }

}
