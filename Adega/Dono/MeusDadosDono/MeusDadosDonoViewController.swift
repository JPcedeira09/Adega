//
//  MeusDadosDonoViewController.swift
//  Adega
//
//  Created by Joao Paulo on 20/02/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase

class MeusDadosDonoViewController: UIViewController {

    var ref: DatabaseReference!

    @IBAction func fechar(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
   ref.child("Adega").child("DadosAdega").observe(.value) { (snapshot) in
            let dict = snapshot.value as! NSDictionary
            let dadosUsuario = DadosAdega(dadosJSON: dict as! [String : Any])
            print("Adega Retornou seus dados do Firebase:\(dadosUsuario)")
//            self.nome.text = usuario.nome
//            self.CPF.text = usuario.cpf
//            self.CEP.text = usuario.cep
//            self.endereco.text = usuario.endereco
//            self.numero.text = usuario.numero
//            self.complemento.text = usuario.complemento
//            self.celular.text = usuario.celular
//            self.atualizar.layer.cornerRadius = 4
        }
    }
    


}
