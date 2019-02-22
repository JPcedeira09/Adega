//
//  MeusDadosViewController.swift
//  Adega
//
//  Created by Joao Paulo on 28/01/19.
//  Copyright © 2019 Joao Paulo. All rights reserved.
//

import UIKit
import Firebase

class MeusDadosViewController: UIViewController {
    
    let user = (Auth.auth().currentUser)!
    var ref = Database.database().reference()
    var usuarioFirebase = Auth.auth()

    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var CPF: UITextField!
    @IBOutlet weak var CEP: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var complemento: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var atualizar: UIButton!
    
    @IBAction func fechar(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref.child("Usuarios").child(user.uid).child("DadosPessoais").observe(.value) { (snapshot) in
            let dict = snapshot.value as! NSDictionary
            let usuario = Usuario(usuarioJSON: dict as! [String : Any])
            print("Usuario que Retornou do Firebase:\(usuario)")
            self.nome.text = usuario.nome
            self.CPF.text = usuario.cpf
            self.CEP.text = usuario.cep
            self.endereco.text = usuario.endereco
            self.numero.text = usuario.numero
            self.complemento.text = usuario.complemento
            self.celular.text = usuario.celular
            self.atualizar.layer.cornerRadius = 4
        }
    }
    
    @IBAction func atualizarAction(_ sender: Any) {
        
        if(validadeTxtField(txtField: self.nome, msg: "Você esqueceu de digitar seu nome!") == true
            && validadeTxtField(txtField: self.CPF, msg: "Você esqueceu de digitar seu CPF!") == true
            && validadeTxtField(txtField: self.CEP, msg: "Você esqueceu de digitar seu CEP!") == true
            && validadeTxtField(txtField: self.endereco, msg: "Você esqueceu de digitar seu endereço!") == true
            && validadeTxtField(txtField: self.numero, msg: "Você esqueceu de digitar seu numero!") == true
            && validadeTxtField(txtField: self.complemento, msg: "Você esqueceu de digitar seu complemento ou ponto de referencia.") == true
            && validadeTxtField(txtField: self.celular, msg: "Você esqueceu de digitar seu celular!") == true){
            
            let nome = self.nome.text!
            let cpf = self.CPF.text!
            let cep = self.CEP.text!
            let endereco = self.endereco.text!
            let numero = self.numero.text!
            let complemento = self.complemento.text!
            let celular = self.celular.text!
            let email = (usuarioFirebase.currentUser?.email)!

            let usuario = Usuario(email: email, nome: nome, cpf: cpf, cep: cep, endereco: endereco, numero: numero, complemento: complemento, celular: celular)

            ref.child("Usuarios")
                .child(user.uid)
                .child("DadosPessoais")
                .updateChildValues(usuario.toDict(usuario))
            
            self.dismiss(animated: true)

//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
//            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    func validadeTxtField(txtField:UITextField , msg:String) -> Bool{
        if(txtField.text! == ""){
            alertSimples(title: "Campo Invalido", msg: msg)
            return false
        }else{
            return true
        }
    }
    
    func alertSimples(title:String , msg:String){
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
