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
    
    var usuario:Usuario?
    let user = (Auth.auth().currentUser)!
    var ref = Database.database().reference()

    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var CPF: UITextField!
    @IBOutlet weak var CEP: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var complemento: UITextField!
    @IBOutlet weak var celular: UITextField!
    @IBOutlet weak var atualizar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nome.text = (self.usuario?.nome)!
        self.CPF.text = (self.usuario?.cpf)!
        self.CEP.text = (self.usuario?.cep)!
        self.endereco.text = (self.usuario?.endereco)!
        self.numero.text = (self.usuario?.numero)!
        self.complemento.text = (self.usuario?.complemento)!
        self.celular.text = (self.usuario?.celular)!
        self.atualizar.layer.cornerRadius = 4
    }
    
    @IBAction func atualizarAction(_ sender: Any) {
        
        if(validadeTxtField(txtField: self.nome, msg: "Você esqueceu de digitar seu nome!") == true
            && validadeTxtField(txtField: self.CPF, msg: "Você esqueceu de digitar seu CPF!") == true
            && validadeTxtField(txtField: self.CEP, msg: "Você esqueceu de digitar seu CEP!") == true
            && validadeTxtField(txtField: self.endereco, msg: "Você esqueceu de digitar seu endereço!") == true
            && validadeTxtField(txtField: self.numero, msg: "Você esqueceu de digitar seu numero!") == true
            && validadeTxtField(txtField: self.complemento, msg: "Você esqueceu de digitar seu complemento ou ponto de referencia.") == true
            && validadeTxtField(txtField: self.celular, msg: "Você esqueceu de digitar seu celular!") == true){
            
            self.usuario?.nome = self.nome.text!
            self.usuario?.cpf = self.CPF.text!
            self.usuario?.cep = self.CEP.text!
            self.usuario?.endereco = self.endereco.text!
            self.usuario?.numero = self.numero.text!
            self.usuario?.complemento = self.complemento.text!
            self.usuario?.celular = self.celular.text!
            
            print(usuario!)
            
            
            ref.child("Usuarios")
                .child(user.uid)
                .child("dados_pessoais")
                .updateChildValues((self.usuario?.toDict(self.usuario!))!)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
            self.present(vc!, animated: true, completion: nil)
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
